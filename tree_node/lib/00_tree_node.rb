class PolyTreeNode
    attr_reader :parent, :value, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        return if parent == parent_node

        if parent
            parent.children.delete(self)
        end

        @parent = parent_node
        parent.children << self if parent != nil
    end

    def add_child(child_node)
        child_node.parent = self
    end 

    def remove_child(child_node)
        if children.include?(child_node)
            child_node.parent = nil 
        else
            raise "node is not a child"
        end
    end 

    def dfs(target)
        return self if value == target

        children.each do |child|
            search_result = child.dfs(target)
            return search_result if !search_result.nil?
        end

        nil
    end 

    def bfs(target)
        queue = [self]

        until queue.empty?
            node = queue.shift
            return node if node.value == target
            node.children.each do |child|
                queue << child
            end
        end

        nil
    end

end