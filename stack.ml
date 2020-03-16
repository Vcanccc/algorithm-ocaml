type 'a t =
  | Empty
  | Item of 'a * 'a t

let rec push stack item = match stack with
  | Empty -> Item (item, Empty)
  | tail -> Item (item, tail)

let pop = function
  | Empty -> None
  | Item (head, rest) -> Some (head, rest)

let peek = function
  | Empty -> None
  | Item (head, _) -> Some head

let rec stack_of_list = function
  | [] -> Empty
  | head :: tail -> Item (head, stack_of_list tail)

let rec list_of_stack = function
  | Empty -> []
  | Item (head, rest) -> head :: list_of_stack rest

let rec fmap f = function
  | Empty -> Empty
  | Item (head, tail) -> Item (f head, fmap f tail)


(* test *)
assert (push Empty 5 = Item (5, Empty));;
assert (push (Item (5, Empty)) 6 = Item (6, Item (5, Empty)));;

assert (pop Empty = None);;
assert (pop (Item (10, Item (4, Empty))) = Some (10, Item (4, Empty)));;

assert (peek Empty = None);;
assert (peek (Item (10, Item (4, Empty))) = Some 10);;

assert (stack_of_list [1; 2; 3] = Item (1, Item (2, Item (3, Empty))));;
assert (stack_of_list [] = Empty);;

assert (list_of_stack (Item (5, Item (2, Item (10, Empty)))) = [5; 2; 10]);;
assert (list_of_stack Empty = []);;
