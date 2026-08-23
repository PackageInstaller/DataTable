local WaitGameCompPool = class("WaitGameCompPool")

function WaitGameCompPool:ctor(arg_1_1)
	self._name = arg_1_1 or "defaultName"
	self._compPool = {}
end

function WaitGameCompPool:getName()
	return self._name
end

function WaitGameCompPool:get()
	if #self._compPool > 0 then
		self._compPool[1]:setVisible(true)
		table.remove(self._compPool, 1)

		return self._compPool[1]
	end
end

function WaitGameCompPool:put(arg_4_1)
	if type(arg_4_1) == "table" then
		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			self:_putNode(iter_4_1)
		end
	else
		self:_putNode(arg_4_1)
	end
end

function WaitGameCompPool:_putNode(arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_1:setVisible(false)
	table.insert(self._compPool, arg_5_1)
end

return WaitGameCompPool
