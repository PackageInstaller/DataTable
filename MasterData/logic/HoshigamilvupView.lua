-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamilvupView.lua

module("logic.extensions.hoshigami.view.HoshigamilvupView", package.seeall)

local HoshigamilvupView = class("HoshigamilvupView", ViewComponent)

function HoshigamilvupView:ctor()
	HoshigamilvupView.super.ctor(self)
end

function HoshigamilvupView:buildUI()
	HoshigamilvupView.super.buildUI(self)

	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function HoshigamilvupView:bindEvents()
	HoshigamilvupView.super.bindEvents(self)
end

function HoshigamilvupView:unbindEvents()
	HoshigamilvupView.super.unbindEvents(self)
end

function HoshigamilvupView:destroyUI()
	HoshigamilvupView.super.destroyUI(self)
end

function HoshigamilvupView:onEnter()
	HoshigamilvupView.super.onEnter(self)

	self._throneId = self:getFirstParam()

	self:_updateView()
end

function HoshigamilvupView:onEnterFinished()
	HoshigamilvupView.super.onEnterFinished(self)
end

function HoshigamilvupView:onExit()
	HoshigamilvupView.super.onExit(self)
end

function HoshigamilvupView:onExitFinished()
	HoshigamilvupView.super.onExitFinished(self)
end

function HoshigamilvupView:_updateView()
	local params = self:getOpenParam()
	local hoshigamiId = params[1]
	local preLv = params[2]
	local preSubPropertyApps = params[3]
	local currLv = params[4]
	local currSubPropertyApps = params[5]
	local lvPlan = HoshigamiModel.instance:getLvPlanIdByHoshigamiId(hoshigamiId)
	local lvStrenCfgs = HoshigamiConfig.instance:getLvStrenCfg(lvPlan)
	local pcfg = lvStrenCfgs[preLv]
	local ccfg = lvStrenCfgs[currLv]
	local preAttrs = self:_getAttrs(pcfg.mainPropertyApp, preSubPropertyApps)
	local currAttrs = self:_getAttrs(ccfg.mainPropertyApp, currSubPropertyApps)

	for k, v in pairs(currAttrs) do
		preAttrs[k] = preAttrs[k] or 0
	end

	local list = {}

	table.insert(list, {
		isLv = true,
		preValue = preLv,
		currValue = currLv
	})

	for k, v in pairs(preAttrs) do
		local var_10_1 = {
			id = k,
			preValue = v
		}

		var_10_1.currValue = currAttrs[k] or 0

		table.insert(list, var_10_1)
	end

	self._itemGroup:updateWithMoArray(list, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local preText = goutil.findChildTextComponent(item.mainGO, "preText")
		local lastText = goutil.findChildTextComponent(item.mainGO, "lastText")

		if data.isLv then
			nameText.text = "强化等级"
			preText.text = data.preValue
			lastText.text = data.currValue
		else
			local name, value = GameUtil.getPropertyInfo(data.id, data.preValue)
			local _, value2 = GameUtil.getPropertyInfo(data.id, data.currValue)

			nameText.text = name
			preText.text = value
			lastText.text = value2
		end
	end)
end

function HoshigamilvupView:_getAttrs(mainPropertyApp, SubPropertyApps)
	local res = {}
	local mainProp = FightingPowerFormula.instance:parseAttrValues(mainPropertyApp) or {}
	local subProp = {}

	if SubPropertyApps then
		for i, v1 in ipairs(SubPropertyApps) do
			local temp = {
				[v1.proertyType] = checknumber(string.format("%.4f", v1.value))
			}

			GameUtil.addSameAttrs(temp, subProp)
		end
	end

	GameUtil.addSameAttrs(mainProp, res)
	GameUtil.addSameAttrs(subProp, res)

	return res
end

return HoshigamilvupView
