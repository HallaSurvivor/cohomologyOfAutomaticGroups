# GAP files for working with automatic group extensions
#
# Chris Grossack, 2019

################
# Conveniences #
################

S := function(n) return SymmetricGroup(n); end;
D := function(n) return DihedralGroup(n);  end; # order 2n

# We will maintain a "datatype" throughout, though we cannot enforce it.
# Extensions will be represented by a list [K, i, G, p, Q] such that
# the obvious sequence is short exact.


#############################################################
# Simplify(G)                                               #
#                                                           #
# Print the generators/relations of a group isomorphic to G #
# Return the new group                                      #
#############################################################

Simplify := function(G)
  local G2;
  G2 := Image(IsomorphismFpGroup(G));
  Print(G2);
  Print("\n");
  Print(RelatorsOfFpGroup(G2));
  Print("\n");

  SetReducedMultiplication(G2); # Make G2 multiplication simplify words
  return G2;
end;


#######################################
# Show(exn)                           #
#                                     #
# Print the relevant info for the exn #
#######################################

Show := function(exn)
  local K,G,Q;
  K := exn[1]; G := exn[3]; Q := exn[5];

  Print("G is given by:\n");
  Print(G); Print("\n");
  Print(RelatorsOfFpGroup(G)); Print("\n\n");
  Print("K is given by:\n");
  Print(K); Print("\n\n");
  Print("Q is given by:\n");
  Print(Q);
end;


#######################################
# GetExns(K,G,Q)                      #
#                                     #
# Return a list of exns K \to G \to Q #
#######################################

GetExns := function(K,G,Q)
  local ks, phi, ret, H;

  G := Simplify(G);

  # all (conjugacy classes of) injections K to G
  ks := IsomorphicSubgroups(G,K); 
  ret := [];
  for phi in ks do
    H := Image(phi);
    if IsNormal(G,H) then
      if IdGroup(FactorGroup(G,H)) = IdGroup(Q) then
        Add(ret, [H, phi, G, NaturalHomomorphismByNormalSubgroup(G,H), FactorGroup(G,H)]);
      fi;
    fi;
  od;
  return ret;
end;


##########################################################
# DoesExnExist(K,Q)                                      #
#                                                        #
# return a list of all G such that 1 -> K -> G -> Q -> 1 #
##########################################################

DoesExnExist := function(K,Q)
  local g, n, ret, i, G;

  g := Size(K) * Size(Q);
  n := NumberSmallGroups(g);
  ret := [];
  for i in [1 .. n] do
    Print(i); Print("/"); Print(n); Print("\n");
    G := SmallGroup(g, i);
    if Length(GetExns(K,G,Q)) > 0 then Add(ret, (g,i)); fi;
  od;
  return ret;
end;


###########################################
# GetSection(exn)                         #
#                                         #
# Choose a coset rep for each member of Q #
###########################################

GetSection := function(exn)
  local ret, x;
  ret := [];
  for x in exn[5] do
    Add(ret, [x, PreImagesRepresentative(exn[4],x)]);
  od;
  return ret;
end;


#####################################################
# GetAction(exn)                                    #
#                                                   #
# Return the action phi (Q \to Aut(K)) given by exn #
#####################################################

#TODO?


##############################
# GetCocyle(exn)             #
#                            #
# Print out \chi (Q^2 \to K) #
##############################

#TODO: make this print to file?
GetCocycle := function(exn)
  local s,x,y;

  s := GetSection(exn);
  Print(s); Print("\n");
  for x in s do
    for y in s do
      Print((x[2] * y[2])^-1 * x[2] * y[2]); # calculate cocycle from section
      Print(", ");
    od;
    Print("\n");
  od;
end;
