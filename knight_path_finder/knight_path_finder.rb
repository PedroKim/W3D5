require_relative 'poly_tree_node'

class KnightPathFinder
    def self.valid_moves(pos)
        # There are up to 8 possible moves

    end

    def initialize(pos)
        @position = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(pos)
    end

    def new_move_positions(pos)
        # should call ::valid_moves
        # but filter out any positions that are already in @considered_positions

        # should add the new remaining positions to @considered_positions
        # and return these new positions
    end

    def build_move_tree
        # use #new_move_positions
        # build your tree in breadth-first manner for efficiency

        # start with the root node representing the start_pos
        # and explore one position at a time.

        # build nodes until queue is empty
    end
end