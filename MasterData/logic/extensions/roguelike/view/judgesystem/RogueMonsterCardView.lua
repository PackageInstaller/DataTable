-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMonsterCardView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMonsterCardView", package.seeall)

local M = class("RogueMonsterCardView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("card_select_view_1429690073")
	self._txtName = self:getText("card_select_view_785639218")
	self._txtCombat = self:getText("card_select_view_2093149817")
	self._txtNum = self:getText("card_select_view_1875410149")
	self._traCardParent = self:getGo("card_select_view_-390070722").transform
	self._cardList = {}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:updateData()
end

function M:updateData()
	local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp

	self._txtName.text = prop:getName()
	self._txtCombat.text = prop:getFighting()
	self._txtNum.text = prop:getHp()

	local actionIds = prop:getFeaturesDices()

	for k, v in pairs(self._cardList) do
		v:setActive(false)
	end

	local curFeatureIndex = RogueMgr.instance:getRogueFlow().judgeMgr:getFeatureIndex()
	local addBase = RogueMgr.instance:getStateMgr():getMonsterAttrBase()

	for k, v in pairs(actionIds) do
		local co = RoguelikeConfig.instance:getMonsterActionById(v)

		if self._cardList[k] == nil then
			local go = self._traCardParent:GetChild(k - 1).gameObject

			item = Astral.LuaComponentContainer.Add(go, RogueJudgeCard)
			self._cardList[k] = item
		end

		local data = {}

		data.name = co.name
		data.co = co

		local pattern = RoguelikeUtil.instance:convertCAttrType2SType(tonumber(co.icon))

		data.attr = RoguelikeConst.AttrType2Name[pattern]
		data.attrLevel = 0

		local round1, round2 = prop:getActionSectionRound(k)
		local rate = 1
		local effectTexts = {}

		for k, v in pairs(co.effect) do
			local effectCo = RoguelikeConfig.instance:getEffectById(v)

			if effectCo then
				local effectParam = effectCo.params

				if string.find(effectParam, "#") then
					rate = tonumber(string.split(effectParam, "#")[2]) or 1
				else
					rate = tonumber(effectParam) or 1
				end

				local round1Temp = math.floor((round1 + addBase) * rate)
				local round2Temp = math.floor((round2 + addBase) * rate)

				table.insert(effectTexts, round1Temp ~= round2Temp and string.format("<color=#ffffff>%s~%s</color>", round1Temp, round2Temp) or string.format("<color=#ffffff>%s</color>", round1Temp))
			end
		end

		local roundText = round1 ~= round2 and string.format("<color=#ffffff>%s~%s</color>", round1, round2) or string.format("<color=#ffffff>%s</color>", round1)
		local effectDesc = ""

		if #co.effect == 1 then
			effectDesc = string.format(co.effectDesc, effectTexts[1])
		elseif #co.effect == 2 then
			effectDesc = string.format(co.effectDesc, effectTexts[1], effectTexts[2])
		elseif #co.effect == 3 then
			effectDesc = string.format(co.effectDesc, effectTexts[1], effectTexts[2], effectTexts[3])
		elseif #co.effect == 4 then
			effectDesc = string.format(co.effectDesc, effectTexts[1], effectTexts[2], effectTexts[3], effectTexts[4])
		end

		data.effect = effectDesc
		data.pattern = tonumber(co.icon)
		data.isDisplay = true

		self._cardList[k]:updateData(data)
	end
end

function M:onExit()
	return
end

function M:_onClickClose()
	self:close()
end

return M
