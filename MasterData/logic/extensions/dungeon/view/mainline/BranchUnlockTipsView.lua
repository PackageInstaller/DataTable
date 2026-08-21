-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/BranchUnlockTipsView.lua

module("logic.extensions.dungeon.view.mainline.BranchUnlockTipsView", package.seeall)

local M = class("BranchUnlockTipsView", ViewComponent)

function M:buildUI()
	self._txtName = self:getText("branch_unlock_tips_-127332522")
	self._txtContent = self:getText("branch_unlock_tips_-254009145")
	self._txtAttributeName = self:getText("branch_unlock_tips_-462334091")
	self._imgAttributeIcon = self:getImage("branch_unlock_tips_-1668153661")
	self._txtAttributeLevel = self:getText("branch_unlock_tips_-150150609")
	self._imgAttributeLvBg = self:getImage("branch_unlock_tips_-117520154")
	self._btnCancel = self:getBtnByPath("content/btnCancel")
	self._btnConfirm = self:getBtnByPath("content/btnConfirm")
	self._btnClose = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._textConfirm = self:getTextByPath("content/btnConfirm/normal/Text1")
	self._attrTyp2Name = {
		"力量",
		"敏捷",
		"知识",
		"沟通",
		"洞察",
		"幸运"
	}
	self._confirmFunc = nil
end

function M:destroyUI()
	self._isEnter = nil
	self._txtName = nil
	self._txtContent = nil
	self._txtAttributeName = nil
	self._imgAttributeIcon = nil
	self._txtAttributeLevel = nil
	self._imgAttributeLvBg = nil
	self._btnCancel = nil
	self._btnConfirm = nil
	self._btnClose = nil
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnClose:AddClickListener(self._onClickCancel, self)
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function M:onEnter(openReasonType)
	self._isEnter = true

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Plot)

	self._attributeTypeReq = nil
	self._attributeLvReq = nil

	self:refreshView()
	self:setEvent(true)
end

function M:onExit(closeReasonType)
	self._isEnter = nil

	self:setEvent(false)

	self._attributeTypeReq = nil
	self._attributeLvReq = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Plot)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickCancel()
	self:close()
end

function M:_onClickConfirm()
	if self._confirmFunc then
		self._confirmFunc(self)
	end
end

function M:getAttribute(attributeType)
	if not attributeType then
		printError(string.format("attribute type is [%s]", attributeType))
	end

	local playerInfo = PlayerModel.instance:getMyPlayerInfo()
	local attributeLst = playerInfo and playerInfo.attribute or {}
	local val = 1

	for _, _PlayerCardAttribute in ipairs(attributeLst) do
		if _PlayerCardAttribute.id == attributeType then
			val = _PlayerCardAttribute.level
		end
	end

	return val
end

function M:refreshView()
	local info = self:getFirstParam()
	local dungeonId = info.dungeonId

	self._dungeonId = dungeonId
	self._inPlotOpen = info and info.inPlotOpen or false

	if not dungeonId then
		printError("dungeonId is nil")
		self:close()

		return
	end

	local attributeType, attributeLv = self:_getRequireAttribute(dungeonId)

	if not attributeType or not attributeLv then
		local plotId, plotValue = self:_getPlotInfo(self._dungeonId)

		if Astral.OSDef.isEditor then
			FloatWordMgr.instance:show(string.format("无法找到关卡[%s]剧情[%s]所需属性点", self._dungeonId, plotId))
		end

		self:close()

		return
	end

	local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)
	local co = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)

	self._txtName.text = dungeonMo:getName()
	self._txtContent.text = co and co.unlockDesc or ""

	self:_refreshAttribute(attributeType, attributeLv)
	self:_refreshConfirmBtn()
end

function M:_refreshAttribute(attributeType, attributeLv)
	if not self._isEnter then
		return
	end

	local attributeEnough = attributeLv <= self:getAttribute(attributeType)

	self._txtAttributeName.text = self._attrTyp2Name[attributeType]
	self._txtAttributeLevel.text = attributeLv

	goutil.setActive(self._imgAttributeIcon.gameObject, true)
	IconLoader.setSprite(self._imgAttributeIcon, IconType.DynSpriteAtlas_Plot, string.format("dice_%s", attributeType))
	goutil.setActive(self._imgAttributeLvBg.gameObject, not attributeEnough)
end

function M:_refreshConfirmBtn()
	local attributeType, attributeLv = self:_getRequireAttribute(self._dungeonId)
	local curAttributeLv = self:getAttribute(attributeType)
	local attributeEnough = attributeLv <= curAttributeLv

	if attributeEnough then
		self._textConfirm.text = lang("unlock_branchline")
		self._confirmFunc = self._unlockBranch
	else
		local attributePoint = ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.AttributePoint)
		local isPointEnough = attributeLv <= attributePoint + curAttributeLv

		if isPointEnough then
			self._textConfirm.text = lang("goto_add_point")
			self._confirmFunc = self._gotoAddPoint
		else
			self._textConfirm.text = lang("not_enough_point")
			self._confirmFunc = nil
		end
	end
end

function M:_gotoAddPoint()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.DisplayCard, true) then
		return
	end

	self:close()

	if self._inPlotOpen then
		printWarn("剧情中点确认")
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
		ViewMgr.instance:open(ViewName.PlayerInfoUpgradeViewPresentor, nil)
	else
		PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId())
	end
end

function M:_unlockBranch()
	local eventLst = {}
	local co = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(self._dungeonId)
	local unlockCondition = co and co.unlockCondition or {}

	for _, v in ipairs(unlockCondition) do
		if v.type == "plot" then
			local arrStep = string.split(v.value, "#")
			local questionKey = tonumber(arrStep[1])
			local answer = tonumber(arrStep[2])

			if questionKey and answer then
				eventLst[questionKey] = answer
			end
		end
	end

	if TableUtil.getLen(eventLst) > 0 then
		GuideAgent.instance:sendSetPlotAnswersRequest(eventLst)
	end

	self:close()
end

function M:_getRequireAttribute(dungeonId)
	if self._attributeTypeReq and self._attributeLvReq then
		return self._attributeTypeReq, self._attributeLvReq
	end

	local plotId, plotValue = self:_getPlotInfo(dungeonId)
	local arrStep = string.split(plotValue, "#")
	local question = tonumber(arrStep[1])
	local index = tonumber(arrStep[2])
	local attrType, attrVal = StoryAttrConfig.instance:getStoryAttrInfo(plotId, question, index)

	self._attributeTypeReq = attrType
	self._attributeLvReq = attrVal

	if not attrType or not attrVal then
		printError(string.format("关卡[%s] 所需解锁剧情id[%s] val[%s], 查询所需属性点失败。", dungeonId, plotId, plotValue))
	end

	return attrType, attrVal
end

function M:_getPlotInfo(dungeonId)
	local co = DungeonConfig.instance:getMainlineDungeonUnlockCOByDungeonId(dungeonId)
	local unlockCondition = co and co.unlockCondition or {}
	local showUnlockCondition = co and co.showUnlockCondition or {}
	local preDungeonId = 0
	local plotId = 0
	local plotValue

	for _, v in ipairs(unlockCondition) do
		if v.type == "dungeon" then
			preDungeonId = tonumber(v.value)
		elseif v.type == "plot" then
			plotValue = v.value
		end
	end

	for _, v in ipairs(showUnlockCondition) do
		if v.type == "dungeon" then
			preDungeonId = tonumber(v.value)
		end
	end

	if preDungeonId > 0 then
		local plotCo = DungeonConfig.instance:getDungeonCfgById(preDungeonId)

		plotCo = plotCo or DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(preDungeonId)
		plotId = plotCo and plotCo.plotBeforeBattle or 0
	end

	return plotId, plotValue
end

return M
