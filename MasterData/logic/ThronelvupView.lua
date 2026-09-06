-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/view/ThronelvupView.lua

module("logic.extensions.throne.view.ThronelvupView", package.seeall)

local ThronelvupView = class("ThronelvupView", ViewComponent)

function ThronelvupView:ctor()
	ThronelvupView.super.ctor(self)
end

function ThronelvupView:buildUI()
	ThronelvupView.super.buildUI(self)

	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function ThronelvupView:bindEvents()
	ThronelvupView.super.bindEvents(self)
end

function ThronelvupView:unbindEvents()
	ThronelvupView.super.unbindEvents(self)
end

function ThronelvupView:destroyUI()
	ThronelvupView.super.destroyUI(self)
end

function ThronelvupView:onEnter()
	ThronelvupView.super.onEnter(self)

	self._throneId = self:getFirstParam()

	self:_updateView()
end

function ThronelvupView:onEnterFinished()
	ThronelvupView.super.onEnterFinished(self)
end

function ThronelvupView:onExit()
	ThronelvupView.super.onExit(self)
end

function ThronelvupView:onExitFinished()
	ThronelvupView.super.onExitFinished(self)
end

function ThronelvupView:_updateView()
	local data = ThroneModel.instance:getThroneData(self._throneId)

	for i = 1, 3 do
		goutil.setActive(self["_item" .. i], false)
	end

	if data then
		local cfg = ThroneConfig.instance:getThroneCfg(self._throneId)
		local lvCfgs = ThroneConfig.instance:getLvStrategyCfg(cfg.levelStrategy)
		local currLvCfg = lvCfgs[data.lv]
		local preLvCfg = lvCfgs[data.lv - 1]
		local satrLv = 1

		for i, v in ipairs(lvCfgs) do
			if not string.nilorempty(v.subProps) then
				satrLv = i - 1

				break
			end
		end

		local currStage = data.lv - satrLv
		local list = {}

		if not string.nilorempty(currLvCfg.subProps) and string.nilorempty(preLvCfg.subProps) then
			table.insert(list, {
				name = "突破提升",
				preTxt = string.format("%s星", data.lv - 1),
				lastTxt = string.format("%s阶", currStage)
			})
		elseif not string.nilorempty(currLvCfg.subProps) and not string.nilorempty(preLvCfg.subProps) then
			table.insert(list, {
				name = "升阶提升",
				preTxt = string.format("%s阶", currStage - 1),
				lastTxt = string.format("%s阶", currStage)
			})
		else
			table.insert(list, {
				name = "强化提升",
				preTxt = string.format("%s星", data.lv - 1),
				lastTxt = string.format("%s星", data.lv)
			})
		end

		local currMainProps = {}
		local preMainProps = {}
		local currSubProps = {}
		local preSubProps = {}
		local tempList1 = string.split(preLvCfg.mainProps, "#")

		for i, v in ipairs(tempList1) do
			local tempList2 = string.split(v, "+")

			preMainProps[tempList2[1]] = checknumber(tempList2[2])
		end

		if not string.nilorempty(preLvCfg.subProps) then
			local tempList3 = string.split(preLvCfg.subProps, "#")

			for i, v in ipairs(tempList3) do
				local tempList4 = string.split(v, "+")

				preSubProps[tempList4[1]] = checknumber(tempList4[2])
			end
		end

		tempList1 = string.split(currLvCfg.mainProps, "#")

		for i, v in ipairs(tempList1) do
			local tempList2 = string.split(v, "+")

			currMainProps[tempList2[1]] = checknumber(tempList2[2])
		end

		if not string.nilorempty(currLvCfg.subProps) then
			local tempList3 = string.split(currLvCfg.subProps, "#")

			for i, v in ipairs(tempList3) do
				local tempList4 = string.split(v, "+")

				currSubProps[tempList4[1]] = checknumber(tempList4[2])
			end
		end

		for k, v in pairs(currMainProps) do
			preMainProps[k] = preMainProps[k] or 0
		end

		for k, v in pairs(currSubProps) do
			preSubProps[k] = preSubProps[k] or 0
		end

		for k, v in pairs(preMainProps) do
			table.insert(list, {
				name = "全体" .. k,
				preTxt = v,
				lastTxt = currMainProps[k]
			})
		end

		for k, v in pairs(preSubProps) do
			table.insert(list, {
				name = "全体" .. k,
				preTxt = v,
				lastTxt = currSubProps[k]
			})
		end

		self._itemGroup:updateWithMoArray(list, function(item, data)
			local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
			local preText = goutil.findChildTextComponent(item.mainGO, "preText")
			local lastText = goutil.findChildTextComponent(item.mainGO, "lastText")

			nameText.text = data.name
			preText.text = data.preTxt
			lastText.text = data.lastTxt
		end)
	end
end

return ThronelvupView
