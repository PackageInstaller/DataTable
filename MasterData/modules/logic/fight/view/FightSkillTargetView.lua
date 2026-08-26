-- chunkname: @modules/logic/fight/view/FightSkillTargetView.lua

module("modules.logic.fight.view.FightSkillTargetView", package.seeall)

local FightSkillTargetView = class("FightSkillTargetView", BaseView)

function FightSkillTargetView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._groupGO = gohelper.findChild(self.viewGO, "group")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._itemList = {}
	self._targetLimit = nil
end

function FightSkillTargetView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.SimulateSelectSkillTargetInView, self._simulateSelect, self)
end

function FightSkillTargetView:removeEvents()
	self.removeEventCb(self, FightController.instance, FightEvent.SimulateSelectSkillTargetInView, self._simulateSelect, self)

	for i = 1, #self._itemList do
		local item = self._itemList[i]

		gohelper.getClick(item.go):RemoveClickListener()
	end
end

function FightSkillTargetView:onOpen()
	PostProcessingMgr.instance:setBlurWeight(1)
	self._simagebg:LoadImage(ResUrl.getFightSkillTargetcIcon("full/zhandouxuanzedi_007"))

	self._targetLimit = self.viewParam.targetLimit
	self._txtDesc.text = self.viewParam.desc and self.viewParam.desc or luaLang("select_skill_target")

	if not self._targetLimit then
		local skillId = self.viewParam.skillId

		self._targetLimit = {}

		local temp = FightHelper.getTargetLimits(FightEnum.EntitySide.MySide, skillId, self.viewParam.fromId)

		for i, entityId in ipairs(temp) do
			local entityMO = FightDataHelper.entityMgr:getById(entityId)

			if entityMO.entityType == 3 then
				-- block empty
			elseif entityMO:hasBuffFeature(FightEnum.BuffType_CantSelect) or entityMO:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
				-- block empty
			else
				local curChapterId = DungeonModel.instance.curSendChapterId

				if curChapterId ~= DungeonEnum.ChapterId.RoleDuDuGu or entityMO.originSkin ~= CharacterEnum.DefaultSkinId.DuDuGu then
					table.insert(self._targetLimit, entityId)
				end
			end
		end
	end

	table.sort(self._targetLimit, FightSkillTargetView._sortByStandPos)

	local itemPath = self.viewContainer:getSetting().otherRes[1]

	for i, entityId in ipairs(self._targetLimit) do
		local item = self._itemList[i]

		if not item then
			local itemGO = self:getResInst(itemPath, self._groupGO, "item" .. i)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, FightSkillTargetItem)

			table.insert(self._itemList, item)
			gohelper.getClick(item.go):AddClickListener(self._onClickItem, self, i)
		end

		gohelper.setActive(item.go, true)
		item:onUpdateMO(entityId)
	end

	for i = #self._targetLimit + 1, #self._itemList do
		gohelper.setActive(self._itemList[i].go, false)
	end

	if self.viewParam.mustSelect then
		self._mustSelect = true

		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)
	end
end

function FightSkillTargetView:_onBtnEsc()
	return
end

function FightSkillTargetView._sortByStandPos(entityId1, entityId2)
	local entityMO1 = FightDataHelper.entityMgr:getById(entityId1)
	local entityMO2 = FightDataHelper.entityMgr:getById(entityId2)

	if entityMO1 and entityMO2 then
		return math.abs(entityMO1.position) < math.abs(entityMO2.position)
	else
		return math.abs(tonumber(entityId1)) < math.abs(tonumber(entityId2))
	end
end

function FightSkillTargetView:_onClickItem(index)
	self:closeThis()
end

function FightSkillTargetView:onClose()
	self._simagebg:UnLoadImage()
	PostProcessingMgr.instance:setBlurWeight(0)
end

function FightSkillTargetView:onClickModalMask()
	if self._mustSelect then
		return
	end

	self:closeThis()
end

function FightSkillTargetView:_simulateSelect(entityId)
	for i, id in ipairs(self._targetLimit) do
		if id == entityId then
			self:_onClickItem(i)

			return
		end
	end

	self:_onClickItem(1)
	logError("模拟选中entity失败，不存在的entityId = " .. entityId .. "，只有：" .. cjson.encode(self._targetLimit))
end

return FightSkillTargetView
