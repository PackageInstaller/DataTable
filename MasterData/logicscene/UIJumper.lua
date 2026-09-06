-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/UIJumper.lua

module("logicscene.scene.UIJumper", package.seeall)

local UIJumper = class("UIJumper")

function UIJumper:ctor()
	self._stacks = {}
end

function UIJumper:saveCurStack(...)
	local withoutMap = {}
	local param = ...
	local withOutViewList

	if param then
		withOutViewList = {
			...
		}
	end

	if withOutViewList then
		for i, v in ipairs(withOutViewList) do
			withoutMap[v] = true
		end
	end

	local stacks = UIStateManager.instance:getCurStacks()

	table.clear(self._stacks)

	local temPool = {}

	for i, v in ipairs(stacks) do
		if v.state and withoutMap[v.state] == nil then
			local stack = {
				closeBefore = true,
				state = v.state,
				param = v.param
			}

			table.insert(self._stacks, stack)

			temPool[v.state] = true
		end
	end

	local views = GlobalModel.instance:getSortingViews()

	for i = #views, 1, -1 do
		local view = views[i]

		if withoutMap[view.viewName] == nil and temPool[view.viewName] == nil and UIStateManager.instance._openPool[view.viewName] then
			local stack = {
				closeBefore = true,
				state = view.viewName,
				param = view._openParam
			}

			table.insert(self._stacks, stack)
		end
	end
end

function UIJumper:pushOneStack(name, close, ...)
	local param = ...
	local tparam

	self._stacks[#self._stacks + 1] = {
		closeBefore = true,
		state = name,
		param = (param or nil) and {
			...
		}
	}
end

function UIJumper:pushClearCurStack(name, close, ...)
	table.clear(self._stacks)
	self:pushOneStack(name, close, ...)
end

function UIJumper:getTopState()
	if not self._stacks then
		return
	end

	for i = #self._stacks, 1, -1 do
		local v = self._stacks[i]

		if not ViewSetting.instance:isModal(v.state) then
			return self._stacks[i]
		end
	end
end

function UIJumper:isInStack(name)
	if not self._stacks then
		return
	end

	for i = #self._stacks, 1, -1 do
		local v = self._stacks[i]

		if v.state == name then
			return true
		end
	end
end

function UIJumper:removeTopState(name)
	if not string.nilorempty(name) then
		for i, stack in ipairs(self._stacks) do
			if stack.state == name then
				table.remove(self._stacks, i)

				break
			end
		end
	end
end

function UIJumper:resumeStack()
	if #self._stacks > 0 then
		local obj = self:getTopState()

		for i, v in ipairs(self._stacks) do
			if ViewSetting.instance:isModal(v.state) then
				if v.param then
					UIStateManager.instance:push(v.state, unpack(v.param))
				else
					UIStateManager.instance:push(v.state)
				end
			elseif v.state == ((obj or nil) and obj.state) then
				if v.param then
					UIStateManager.instance:push(v.state, unpack(v.param))
				else
					UIStateManager.instance:push(v.state)
				end
			elseif v.param then
				UIStateManager.instance:pushWithoutEnterState(v.state, unpack(v.param))
			else
				UIStateManager.instance:pushWithoutEnterState(v.state)
			end
		end

		table.clear(self._stacks)
	else
		local root = UIStateManager.instance:getRoot()

		UIStateManager.instance:push(root)
	end
end

function UIJumper:clear()
	table.clear(self._stacks)
end

UIJumper.instance = UIJumper.New()

return UIJumper
