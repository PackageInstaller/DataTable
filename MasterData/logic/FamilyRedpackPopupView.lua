-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyRedpackPopupView.lua

module("logic.extensions.family.view.FamilyRedpackPopupView", package.seeall)

local FamilyRedpackPopupView = class("FamilyRedpackPopupView", TableViewComponent)

function FamilyRedpackPopupView:ctor()
	FamilyRedpackPopupView.super.ctor(self)

	self._redpackInfo = nil
	self._curViewDatas = nil
	self._curPrize = nil
end

function FamilyRedpackPopupView:destroyUI()
	FamilyRedpackPopupView.super.destroyUI(self)
end

function FamilyRedpackPopupView:onExit()
	FamilyRedpackPopupView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Family_GainFamilyRedpackInfo, self._showRedpackViewInfo, self)
	MaterialMgr.resetAll(self._cHeadGo)
	MaterialMgr.resetAll(self._oHeadGo)
	MaterialMgr.resetAll(self._prizeIconGo)

	self._redpackInfo = nil
	self._curViewDatas = nil
	self._curPrize = nil
	self._changeSetId = nil
end

function FamilyRedpackPopupView:unbindEvents()
	FamilyRedpackPopupView.super.unbindEvents(self)
	self._clickBtn:RemoveClickListener()
	GameUtil.asBtn(self._closeGo):RemoveClickListener()
end

function FamilyRedpackPopupView:bindEvents()
	FamilyRedpackPopupView.super.bindEvents(self)
	self._clickBtn:AddClickListener(function()
		if checknumber(self._changeSetId) > 0 then
			MaterialController.instance:showChangeSetInTemp(self._changeSetId)
		end

		self:close()
	end, self)
	GameUtil.asBtn(self._closeGo):AddClickListener(self._onClickCloseBtn, self)
end

function FamilyRedpackPopupView:buildUI()
	FamilyRedpackPopupView.super.buildUI(self)

	self._clickBtn = self:getBtn("clickBtn")
	self._closeGo = self:getGo("closeGo")
	self._closeIsc = self._closeGo:GetComponent("UIImageSpriteChange")
	self._cHeadGo = goutil.findChild(self._closeGo, "headGo")
	self._cNameTxt = goutil.findChildTextComponent(self._closeGo, "nameGo/nameTxt")
	self._cDescGo = goutil.findChild(self._closeGo, "descGo")
	self._cDescTxt = goutil.findChildTextComponent(self._closeGo, "descTxt")
	self._openGo = self:getGo("openGo")
	self._openIsc = self._openGo:GetComponent("UIImageSpriteChange")
	self._oHeadGo = goutil.findChild(self._openGo, "headGo")
	self._oNameTxt = goutil.findChildTextComponent(self._openGo, "nameGo/nameTxt")
	self._oPrizeGo = goutil.findChild(self._openGo, "prizeGo")
	self._prizeIconGo = goutil.findChild(self._oPrizeGo, "prizeIconGo")
	self._prizeTxt = goutil.findChildTextComponent(self._oPrizeGo, "prizeTxt")
	self._oDescTxt = goutil.findChildTextComponent(self._openGo, "descGo/descTxt")
	self._oTaskTxt = goutil.findChildTextComponent(self._openGo, "taskTxt")
	self._effShowGo = self:getGo("effShowGo")
end

function FamilyRedpackPopupView:onEnter()
	FamilyRedpackPopupView.super.onEnter(self)

	local rpId = checknumber(self:getFirstParam())

	if rpId <= 0 then
		printError("sr---   FamilyRedpackPopupView:onEnter()    请传入红包id")
		self:close()

		return
	end

	self._redpackInfo = FamilyModel.instance:getInfoByRedpackId(rpId)

	if self._redpackInfo == nil then
		printError("sr---   FamilyRedpackPopupView:onEnter()    没有当前红包数据 = " .. rpId)
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.Family_GainFamilyRedpackInfo, self._showRedpackViewInfo, self)

	self._isOpenRp = false

	self:_showRedpackViewInfo()
end

function FamilyRedpackPopupView:_showRedpackViewInfo(msg)
	self._changeSetId = nil

	if msg then
		if msg.redPacketList then
			self._redpackInfo = msg.redPacketList
		end

		if msg.changeSetId then
			self._changeSetId = msg.changeSetId
		end
	end

	self._curViewDatas = {}

	local typeCfg = FamilyConfig.instance:getRedpackTypeCfg(self._redpackInfo.packetType)
	local taskCfg = FamilyConfig.instance:getRedpackTaskCfgsById(self._redpackInfo.taskId)

	self._curPrize = typeCfg.prize

	if self._redpackInfo.canGain then
		GameUtil.SetActive(self._openGo, false)
		GameUtil.SetActive(self._closeGo, true)
		self._closeIsc:SetState(typeCfg.packetType - 1)
		HeadItemController.instance:setHeadCellByInfo(self._cHeadGo, self._redpackInfo.headInfo)

		self._cNameTxt.text = self._redpackInfo.headInfo.userName

		GameUtil.SetActive(self._cDescGo, typeCfg.packetType ~= 1)

		self._cDescTxt.text = taskCfg.taskDesc
	else
		GameUtil.SetActive(self._closeGo, false)
		GameUtil.SetActive(self._openGo, true)
		self._openIsc:SetState(typeCfg.packetType - 1)
		HeadItemController.instance:setHeadCellByInfo(self._oHeadGo, self._redpackInfo.headInfo)

		self._oNameTxt.text = self._redpackInfo.headInfo.userName

		local count = self:_getOwnGrabRedpackCount()

		if count <= 0 then
			GameUtil.SetActive(self._oPrizeGo, false)
		else
			GameUtil.SetActive(self._oPrizeGo, true)
			MaterialMgr.updateItemByStr(self._prizeIconGo, self._curPrize)

			self._prizeTxt.text = tostring(count)
		end

		local allCount, number = self:_getAllGrabRedpackCount()

		self._oDescTxt.text = langPara("text_family_desc_15", allCount, typeCfg.num, number, typeCfg.people)
		self._oTaskTxt.text = taskCfg.taskTitle
		self._curViewDatas = self._redpackInfo.record or {}

		if #self._curViewDatas > 1 then
			table.sort(self._curViewDatas, function(a, b)
				return a.gainTime < b.gainTime
			end)
		end

		self:reloadData()
	end
end

function FamilyRedpackPopupView:_getOwnGrabRedpackCount()
	if self._redpackInfo == nil or self._redpackInfo.canGain or self._redpackInfo.record == nil then
		return 0
	end

	local userId = RoleModel.instance:getUserId()

	for _, info in pairs(self._redpackInfo.record) do
		if info and info.headInfo and info.headInfo.userId == userId then
			return info.num
		end
	end

	return 0
end

function FamilyRedpackPopupView:_getAllGrabRedpackCount()
	local count, number = 0, 0

	if self._redpackInfo == nil or self._redpackInfo.record == nil then
		return count, number
	end

	for _, info in pairs(self._redpackInfo.record) do
		if info and checknumber(info.num) > 0 then
			count = count + info.num
			number = number + 1
		end
	end

	return count, number
end

function FamilyRedpackPopupView:_getPath()
	return {
		cellPath = "openGo/recordItem",
		viewPath = "openGo/itemListSR"
	}
end

function FamilyRedpackPopupView:_cellSize()
	return 300, 80
end

function FamilyRedpackPopupView:_updateCell(view, cell, data)
	local kingGo = goutil.findChild(cell, "kingGo")
	local userGo = goutil.findChild(cell, "userGo")
	local getTxt = goutil.findChildTextComponent(cell, "getTxt")
	local getGo = goutil.findChild(cell, "getGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")

	MaterialMgr.resetAll(userGo)
	GameUtil.SetActive(kingGo, data.isLucky)
	HeadItemController.instance:setHeadCellByInfo(userGo, data.headInfo)

	getTxt.text = tostring(data.num)

	MaterialMgr.updateItemByStr(getGo, self._curPrize)

	nameTxt.text = data.headInfo.userName
end

function FamilyRedpackPopupView:_onClickCloseBtn()
	if self._isOpenRp then
		return
	end

	if self._redpackInfo == nil or not self._redpackInfo.canGain then
		FloatWordMgr.instance:show(lang("text_family_desc_16"))

		return
	end

	local typeCfg = FamilyConfig.instance:getRedpackTypeCfg(self._redpackInfo.packetType)
	local redTimes = FamilyModel.instance:getFaimlyRedpackData().redTimes

	if typeCfg and checknumber(redTimes[self._redpackInfo.packetType]) >= typeCfg.dailyLimit then
		FloatWordMgr.instance:show(langPara("text_family_desc_17", typeCfg.name))

		return
	end

	if self._redpackInfo.expire / 1000 <= ServerTime.now() then
		FloatWordMgr.instance:show(lang("text_family_desc_11"))

		return
	end

	local path = "20221223/jiazuhongbao/fx_ui_jzhb_di_dianji.prefab"

	if self._redpackInfo.packetType == 1 then
		path = "20221223/jiazuhongbao/fx_ui_jzhb_gao_dianji.prefab"
	elseif self._redpackInfo.packetType == 2 then
		path = "20221223/jiazuhongbao/fx_ui_jzhb_zhong_dianji.prefab"
	end

	UIEffectManager.instance:playEffect(self, path, self._effShowGo, 0, 0, false, false, function(view, eff)
		self._isOpenRp = false
	end, function(view, eff)
		self._isOpenRp = true

		goutil.addChildToParent(eff.effGo, self._effShowGo)
		GameUtil.setLocalPos(eff.effGo, 3, -12, 0)
		GameUtil.setLocalScale(eff.effGo, 1.72, 1.72, 1.72)
		FamilyController.instance:csGetFamilyRedPacketGainReq(self._redpackInfo.packetId, self._redpackInfo.packetType)
	end, self)
end

return FamilyRedpackPopupView
