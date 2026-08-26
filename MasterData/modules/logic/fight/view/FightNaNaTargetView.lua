-- chunkname: @modules/logic/fight/view/FightNaNaTargetView.lua

module("modules.logic.fight.view.FightNaNaTargetView", package.seeall)

local FightNaNaTargetView = class("FightNaNaTargetView", BaseView)

function FightNaNaTargetView:onInitView()
	self._goUnSelected = gohelper.findChild(self.viewGO, "#go_UnSelected")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goItemGroup = gohelper.findChild(self.viewGO, "#go_itemgroup")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#go_Selected/#txt_SkillName")
	self._txtSkillDescr = gohelper.findChildText(self.viewGO, "#go_Selected/#txt_SkillDescr")
	self._btnSign = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Sign")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightNaNaTargetView:addEvents()
	self._btnSign:AddClickListener(self._btnSignOnClick, self)
end

function FightNaNaTargetView:removeEvents()
	self._btnSign:RemoveClickListener()
end

function FightNaNaTargetView:_btnSignOnClick()
	if self.curSelectEntity == 0 then
		return
	end

	AudioMgr.instance:trigger(20220174)
	FightRpc.instance:sendUseClothSkillRequest(0, self.nanaEntityId, self.curSelectEntity, FightEnum.ClothSkillType.Contract)
end

function FightNaNaTargetView:_editableInitView()
	self.goBtnSign = self._btnSign.gameObject

	gohelper.setActive(self.goBtnSign, false)

	local resPath = self.viewContainer:getSetting().otherRes[1]

	self.itemPrefab = self.viewContainer:getRes(resPath)
	self.itemList = {}

	self:initCareerBindBuff()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self.onStartPlayClothSkill, self, LuaEventSystem.High)
	self.addEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self.closeThis, self, LuaEventSystem.High)
end

function FightNaNaTargetView.blockEsc()
	return
end

function FightNaNaTargetView:onStartPlayClothSkill()
	self:closeThis()
end

function FightNaNaTargetView:onOpen()
	AudioMgr.instance:trigger(20220172)

	self.curSelectEntity = 0
	self.entityIdList = FightModel.instance.canContractList
	self.nanaEntityId = FightModel.instance.notifyEntityId

	local nanaEntityMo = FightDataHelper.entityMgr:getById(self.nanaEntityId)

	if nanaEntityMo then
		self.nanaExSkillLv = nanaEntityMo.exSkillLevel or 0
	end

	table.sort(self.entityIdList, FightNaNaTargetView.sortEntityId)

	for _, entityId in ipairs(self.entityIdList) do
		self:addItem(entityId)
	end

	self:refreshSelect()
	FightModel.instance:setNotifyContractInfo(nil, nil)
end

function FightNaNaTargetView.sortEntityId(entityId1, entityId2)
	local entityMo1 = FightDataHelper.entityMgr:getById(entityId1)

	if not entityMo1 then
		return false
	end

	local entityMo2 = FightDataHelper.entityMgr:getById(entityId2)

	if not entityMo2 then
		return false
	end

	return entityMo1.position < entityMo2.position
end

function FightNaNaTargetView:initCareerBindBuff()
	local value = lua_fight_const.configDict[31].value
	local careerList = FightStrUtil.instance:getSplitCache(value, "|")

	self.careerDict = {}

	for _, careerItem in ipairs(careerList) do
		local strList = string.split(careerItem, "%")
		local career = tonumber(strList[1])

		for _, str in ipairs(string.split(strList[2], ",")) do
			local valueList = string.splitToNumber(str, ":")
			local exSkillLevel = valueList[1]
			local tempDict = self.careerDict[exSkillLevel]

			if not tempDict then
				tempDict = {}
				self.careerDict[exSkillLevel] = tempDict
			end

			tempDict[career] = valueList[2]
		end
	end
end

function FightNaNaTargetView:addItem(entityId)
	local item = self:getUserDataTb_()

	item.go = gohelper.clone(self.itemPrefab, self._goItemGroup)
	item.goSelect = gohelper.findChild(item.go, "#go_SelectedFrame")
	item.simageIcon = gohelper.findChildSingleImage(item.go, "icon")
	item.imageCareer = gohelper.findChildImage(item.go, "#image_Attr")

	local entityMo = FightDataHelper.entityMgr:getById(entityId)

	if entityMo then
		local skinConfig = FightConfig.instance:getSkinCO(entityMo.skin)

		item.simageIcon:LoadImage(ResUrl.getHeadIconSmall(skinConfig and skinConfig.retangleIcon))
	end

	local career = entityMo.career

	UISpriteSetMgr.instance:setCommonSprite(item.imageCareer, "lssx_" .. career)

	item.uid = entityId
	item.click = gohelper.getClickWithDefaultAudio(item.go)

	item.click:AddClickListener(self.onClickItem, self, entityId)
	table.insert(self.itemList, item)
end

function FightNaNaTargetView:onClickItem(entityUid)
	if entityUid == self.curSelectEntity then
		return
	end

	AudioMgr.instance:trigger(20220173)

	self.curSelectEntity = entityUid

	self:refreshSelect()
end

function FightNaNaTargetView:refreshSelect()
	gohelper.setActive(self.goBtnSign, self.curSelectEntity ~= 0)
	self:refreshSelectStatus()
	self:refreshSelectText()
end

function FightNaNaTargetView:refreshSelectStatus()
	for _, item in ipairs(self.itemList) do
		local select = item.uid == self.curSelectEntity

		gohelper.setActive(item.goSelect, select)
	end
end

function FightNaNaTargetView:refreshSelectText()
	local select = self.curSelectEntity ~= 0

	gohelper.setActive(self._goSelected, select)
	gohelper.setActive(self._goUnSelected, not select)

	if select then
		self:refreshBuffText()
	end
end

function FightNaNaTargetView:refreshBuffText()
	local entityMo = FightDataHelper.entityMgr:getById(self.curSelectEntity)

	if not entityMo then
		logError("没找到entityMo : " .. tostring(self.curSelectEntity))

		return
	end

	if not self.careerDict[self.nanaExSkillLv] then
		local careerDict = self.careerDict[0]
		local career = entityMo.career
		local buffId = career and careerDict[career]
		local buffCo = buffId and lua_skill_buff.configDict[buffId]

		if not buffCo then
			logError("没找到buffCo : " .. tostring(buffId))

			return
		end

		self._txtSkillName.text = buffCo.name
		self._txtSkillDescr.text = buffCo.desc
	end
end

function FightNaNaTargetView:onClose()
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.BindContract)
end

function FightNaNaTargetView:onDestroyView()
	for _, item in ipairs(self.itemList) do
		item.simageIcon:UnLoadImage()
		item.click:RemoveClickListener()
	end

	self.itemList = nil
end

return FightNaNaTargetView
