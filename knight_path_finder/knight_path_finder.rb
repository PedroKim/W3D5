require 'byebug'
require_relative 'poly_tree_node'

class KnightPathFinder
    attr_reader :root_node
    attr_accessor :considered_positions

    def self.valid_moves(pos)
        # There are up to 8 possible moves
        row, col = pos

        possible_positions = [
            [row + 1, col - 2], [row - 1, col - 2], # 2 left 1 up / 1 down
            [row + 1, col + 2], [row - 1, col + 2],  # 2 right 1 up / 1 down
            [row + 2, col - 1], [row + 2, col + 1], # 2 up 1 left / 1 right
            [row - 2, col - 1], [row - 2, col + 1] # 2 down 1 left / 1 right
        ]

        possible_positions.select do |pos| 
            row, col = pos
            row >= 0 && col >= 0 && row <= 7 && col <= 7
        end
    end

    def initialize(pos)
        @position = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(pos)

        # build_move_tree should happen here
        self.build_move_tree
    end

    def new_move_positions(pos)
        # call ::valid_moves
        new_positions = KnightPathFinder.valid_moves(pos)

        # filter out any positions that are already in @considered_positions
        @considered_positions.each { |pos| new_positions.delete(pos) }

        # add the new remaining positions to @considered_positions
        @considered_positions += new_positions

        # return these new positions
        new_positions
    end

    def build_move_tree
        # build your tree in breadth-first manner for efficiency

        # starting with the root node representing the start_pos
        queue = [root_node]

        # build nodes until queue is empty
        until queue.empty?
            node = queue.shift

            # use #new_move_positions
            new_pos = new_move_positions(node.value)

            # explore one position at a time
            new_pos.each do |pos|
                child_node = PolyTreeNode.new(pos)
                child_node.parent = node
                queue << child_node
            end 
        end

    end

    def find_path(end_pos)
        # We're going to find path using either DFS or BFS
        end_pos_node = root_node.dfs(end_pos)
        
        # use #trace_path_back to get trace path
        trace_path = trace_path_back(end_pos_node)
    end

    def trace_path_back(end_node)
        path = [end_node.value]

        until end_node.value == root_node.value
            end_node = end_node.parent
            path.unshift(end_node.value)
        end

        path
    end 

end