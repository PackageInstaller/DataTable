-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityAchievePubDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResTigerBandit = require("ClientData/ResTigerBandit")
local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local AchiCell = Class("AchiCell", UIControls.Panel)

function AchiCell:ctor()
	self.imgGet = UIControls.Image(self, self.mPath .. "/ImgGet")
	self.textName = UIControls.Label(self, self.mPath .. "/BgName/TextName1")
	self.btnAward = {}
	self.imgIcon = {}

	for i = 1, 2 do
		self.btnAward[i] = UIControls.Button(self, self.mPath .. "/BtnAward" .. i)
		self.imgIcon[i] = UIControls.Image(self, self.mPath .. "/BtnAward" .. i .. "/Icon")
	end

	self.AniAchiCell = UIControls.Panel(self, self.mPath)
	self.btnGet = UIControls.Button(self, self.mPath .. "/BtnGet")

	self.btnGet:addEventClick(self.onBtnOneAchieveGet)
end

function AchiCell:setData(data, tabaward, percentIndexNum, got, opId)
	if got then
		self.AniAchiCell:playStateAnimator("OpenAchiAwardNml")
	elseif percentIndexNum >= data.index then
		self.AniAchiCell:playStateAnimator("OpenAchiAwardSel")
		self.btnAward[1]:setObjGray(false)
		self.btnAward[2]:setObjGray(false)
	else
		self.AniAchiCell:playStateAnimator("OpenAchiAwardDis")
		self.btnAward[1]:setObjGray(true)
		self.btnAward[2]:setObjGray(true)
	end

	self.btnGet.indexnum = data.index
	self.btnGet.type = data.type
	self.btnGet.opId = opId

	self.textName:setText(data.desc_name)

	for i = 1, 2 do
		if tabaward[i] then
			self.btnAward[i]:setVisible(true)

			if data.achieve_bonus[i] then
				local path = "Atlas/ActivityAtlas/" .. data.achieve_bonus[i].icon_path
				local icon = data.achieve_bonus[i].icon

				self.imgIcon[i]:setImage(path, icon)
			end

			self.btnAward[i].itemId = tabaward[i].itemId
			self.btnAward[i].itemNum = tabaward[i].itemNum

			self.btnAward[i]:addEventClick(self.onBtnTipsAchieve)
		else
			self.btnAward[i]:setVisible(false)
		end
	end
end

function AchiCell:onBtnOneAchieveGet(sender)
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, sender.opId, sender.indexnum, sender.type), sender.opId)
end

function AchiCell:onBtnTipsAchieve(sender)
	self.mDisableWays = true

	BaseObject.ShowObjectTips(sender.itemId, sender.itemNum, self)
end

function AchiCell:setAward()
	return
end

local strClassName = "ActivityAchievePubDlg"
local ActivityAchievePubDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityAchievePubDlg, ActivityPanelMixin)

local MAX_SHOW_NUM = 4

function ActivityAchievePubDlg:initUI()
	self.textDes = UIControls.Label(self, "BgPanel/BgDes/TextDes")
	self.textProgress = UIControls.Label(self, "BgPanel/GetPanel/TextNum")
	self.btnPlotAchieve = UIControls.Button(self, "BgPanel/SignPanel/BtnConfirm")
	self.textGetAchieveNum = UIControls.Label(self, "BgPanel/SignPanel/TextNum")
	self.panelSignPanel = UIControls.Panel(self, "BgPanel/SignPanel")

	self.btnPlotAchieve:addEventClick(self.onBtnPlotAchieve)

	self.sliderAchieve = UIControls.Slider(self, "BgPanel/AwardPanel/Slider")
	self.imgProgress = UIControls.Image(self, "BgPanel/GetPanel/Icon")
	self.imgGetAward = UIControls.Image(self, "BgPanel/SignPanel/Icon")
	self.pointText = {}

	for i = 1, MAX_SHOW_NUM + 1 do
		self.pointText[i] = UIControls.Label(self, "BgPanel/AwardPanel/Slider/PointPanel/Point" .. i .. "/TextNum")
	end

	self.pointImage = {}

	for i = 1, MAX_SHOW_NUM + 1 do
		self.pointImage[i] = UIControls.Image(self, "BgPanel/AwardPanel/Slider/PointPanel/Point" .. i)
	end

	self.cells = {}

	for i = 1, MAX_SHOW_NUM do
		self.cells[i] = AchiCell(self, "BgPanel/AwardPanel/AchiCell" .. i)
	end
end

function ActivityAchievePubDlg:_setOtherData()
	local relationItem = ResOpActivityClientTemplate[self.actObj.actId]

	self.relationId = tonumber(relationItem.template_args[1])
	self.dataOtherAchieve = CurAvatar:getActivityObj(self.relationId)
	self.progressNow = 0

	if next(self.dataOtherAchieve.actData.serverData) then
		self.progressNow = self.dataOtherAchieve.actData.serverData[1].progress
	end

	CurAvatar:addActivityRelated(self.relationId, "activityAchievePubDlg")

	self.dataOtherbd = ResOpActivityAchieveDetail[self.dataOtherAchieve.actId] or {}
end

function ActivityAchievePubDlg:_onShow()
	self:_setOtherData()

	self.clientAchieveData = ResOpActivityAchieveDetail[self.actObj.actId] or {}

	for i, datatype in pairs(self.clientAchieveData) do
		self.indexType = i
	end

	self.clientAchieveData = self.clientAchieveData[self.indexType] or {}
	self.templateData = ResOpActivityTemplate[self.actObj.actId] or {}

	self.textDes:setText(self.templateData.rule_desc)

	local data = self.templateData.param
	local iconPath = BaseObject.getItemIconPath(data[1])

	if iconPath then
		self.imgProgress:setImage(iconPath[1], iconPath[2])
		self.imgGetAward:setImage(iconPath[1], iconPath[2])
	end

	self.pointText[1]:setText("0")
	self.pointText[1]:setFontColor(ResColor.RED02)

	for index = 1, MAX_SHOW_NUM do
		local pointText = self.pointText[index + 1]
		local data = self.clientAchieveData[index]

		if data then
			pointText:setText(data.param)
			pointText:setFontColor(ResColor.WHITE)
		end
	end

	self.progressNum = 0

	self:setHasGetAwardState()
end

function ActivityAchievePubDlg:setHasGetAwardState()
	if next(self.actObj.actData.serverData) then
		local newInfo = self.actObj.actData.serverData

		for i, datatype in pairs(newInfo) do
			self.progressNum = newInfo[i].progress
		end
	end

	self.textProgress:setText(self.progressNum)

	local percent = self.progressNum / self.clientAchieveData[#self.clientAchieveData].param

	self.sliderAchieve:setValue(percent)

	self.percentIndexNum = 0

	if percent >= 0 and percent < 0.25 then
		self.percentIndexNum = 0
	elseif percent >= 0.25 and percent < 0.5 then
		self.percentIndexNum = 1
	elseif percent >= 0.5 and percent < 0.75 then
		self.percentIndexNum = 2
	elseif percent >= 0.75 and percent < 1 then
		self.percentIndexNum = 3
	else
		self.percentIndexNum = 4
	end

	for i = 0, self.percentIndexNum do
		self.pointText[i + 1]:setFontColor(ResColor.RED02)
		self.pointImage[i + 1]:setImage("Atlas/ActivityAtlas/ActivityOpenAchiAtlas/ActivityOpenAchiAtlas", "BgScoreOn")
	end

	self:setClieAwardState()
end

function ActivityAchievePubDlg:setClieAwardState()
	local cachData = self.clientAchieveData

	for idx, tabdata in ipairs(cachData) do
		local _tabaward = {}
		local awardid = tabdata.award

		_tabaward.awarddes = tabdata.desc_name

		for i, itemId in ipairs(ResRandClient[awardid].show_ids) do
			local awardtab = {}

			awardtab.itemNum = ResRandClient[awardid].show_nums[i]
			awardtab.itemId = ResRandClient[awardid].show_ids[i]

			table.insert(_tabaward, awardtab)
		end

		local got

		if next(self.actObj.actData.serverData) then
			local type

			for i, itp in pairs(self.actObj.actData.serverData) do
				type = i
			end

			local tabgot = self.actObj.actData.serverData[type].got

			if tabgot[idx] ~= nil then
				got = tabgot[idx]
			end
		end

		self.cells[idx]:setData(tabdata, _tabaward, self.percentIndexNum, got, self.actObj.opId)
	end

	local allhasGet = true

	if next(self.dataOtherAchieve.actData.serverData) and self.dataOtherAchieve.actData.serverData[1].progress ~= 0 then
		allhasGet = false
	end

	if allhasGet then
		self.panelSignPanel:setVisible(false)
	else
		self.panelSignPanel:setVisible(true)
		self.textGetAchieveNum:setText("x" .. self.dataOtherAchieve.actData.serverData[1].progress)
	end
end

function ActivityAchievePubDlg:onBtnPlotAchieve()
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.dataOtherAchieve.opId, -1, self.dataOtherAchieve.roleData.achieve.data[1].type), self.dataOtherAchieve.opId)
end

function ActivityAchievePubDlg:onShowAnimOver()
	self.onOpenAniOver = true

	self:checkBattleAnim()
end

function ActivityAchievePubDlg:getSpecialBonus(notifyType, attrs, items, heros, equip, artifact, relic)
	if items and #items > 0 and items[1].id == 510202 then
		local itemObjs = ClientUtils.getAllClientItems(attrs, items, heros, equip, artifact, relic)

		for _, item in ipairs(itemObjs) do
			MsgManager.notice(utils.format(Lang.get(1875), item.name, item.num))
		end

		return true
	end
end

function ActivityAchievePubDlg:updateRelatedActivityData(actObj)
	local data = self.templateData.param
	local itemId = data[1]
	local type

	for i, itp in pairs(self.actObj.actData.serverData) do
		type = i
	end

	FlyIconUtils.setFlyUItoUI(self.panelSignPanel, self.imgProgress, itemId, self.progressNow)
	self.panelSignPanel:setVisible(false)
	self:setHasGetAwardState()
end

function ActivityAchievePubDlg:updateActivityData(actObj)
	self:setClieAwardState()
end

function ActivityAchievePubDlg:destroy()
	ActivityAchievePubDlg.super.destroy(self)
end

return ActivityAchievePubDlg
