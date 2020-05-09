StateMachine = Class{}


function StateMachine:init(list)
    self.empty = {
        render = function() end,
		update = function() end,
		enter = function() end,
		exit = function() end
    }
    self.currentState = self.empty
    self.stateList = list

end

function StateMachine:changeState(newState, parameters)
    assert(self.stateList[newState])
    self.currentState:exit()
    self.currentState = self.stateList[newState]()
    self.currentState:enter(parameters)
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end