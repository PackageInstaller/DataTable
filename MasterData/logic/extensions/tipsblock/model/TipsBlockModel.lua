-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tipsblock/model/TipsBlockModel.lua

module("logic.extensions.tipsblock.model.TipsBlockModel", package.seeall)

local M = class("TipsBlockModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._blockViewLst = {}
end

function M:addToBlockLst(viewName, ...)
	local info = TipsBlockUtil.getInfo(viewName)

	if not info and enableLog then
		TipsBlockUtil.print(string.format("界面 :%s 未定义block属性", viewName), true)
	end

	self._blockViewLst[#self._blockViewLst + 1] = {
		viewName = viewName,
		params = {
			...
		}
	}

	self:_sortBlockLst()

	if Astral.OSDef.isEditor then
		TipsBlockUtil.print(string.format("界面 :%s 添加队列", viewName), true)
		TableUtil.dump(self._blockViewLst)
	end
end

function M:removeFromBlockLst(viewName, onlyFirst)
	local newLst = {}
	local find = false

	for index, value in ipairs(self._blockViewLst or {}) do
		local add = false

		if value.viewName == viewName then
			if find then
				add = onlyFirst
			end

			find = true
		else
			add = true
		end

		if add then
			table.insert(newLst, value)
		end
	end

	self._blockViewLst = newLst

	if Astral.OSDef.isEditor then
		TipsBlockUtil.print(string.format("界面 :%s 移除队列", viewName), true)
		TableUtil.dump(self._blockViewLst)
	end
end

function M:_sortBlockLst()
	local len = self._blockViewLst and #self._blockViewLst or 0

	if len > 0 then
		table.sort(self._blockViewLst, function(a, b)
			local infoA = TipsBlockUtil.getInfo(a.viewName)
			local infoB = TipsBlockUtil.getInfo(b.viewName)
			local priorityA = infoA and infoA.priority or 0
			local priorityB = infoB and infoB.priority or 0

			if priorityA ~= priorityB then
				return priorityB < priorityA
			end

			return infoA.id < infoB.id
		end)
	end

	return self._blockViewLst
end

function M:getTopViewName()
	local viewName
	local len = self._blockViewLst and #self._blockViewLst or 0

	if len > 0 then
		viewName = self._blockViewLst[1].viewName

		if len > 1 and not TipsBlockUtil.canOpen(viewName) then
			local findIndex, findViewName

			for index, value in ipairs(self._blockViewLst) do
				if TipsBlockUtil.canOpen(value.viewName) then
					if findViewName then
						if TipsBlockUtil.getPriority(value.viewName) > TipsBlockUtil.getPriority(findViewName) then
							findIndex = index
							findViewName = value.viewName
						end
					else
						findIndex = index
						findViewName = value.viewName
					end
				end
			end

			if findIndex then
				local data = table.remove(self._blockViewLst, findIndex)

				table.insert(self._blockViewLst, 1, data)

				viewName = self._blockViewLst[1].viewName
			end
		end
	end

	return viewName
end

function M:popView()
	local len = self._blockViewLst and #self._blockViewLst or 0

	if len == 0 then
		return nil
	end

	local data = table.remove(self._blockViewLst, 1)

	return data
end

M.instance = M.New()

return M
