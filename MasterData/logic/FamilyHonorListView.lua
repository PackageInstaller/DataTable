-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyHonorListView.lua

module("logic.extensions.newfamily.view.FamilyHonorListView", package.seeall)

local FamilyHonorListView = class("FamilyHonorListView", TableViewComponent)

function FamilyHonorListView:ctor()
	FamilyHonorListView.super.ctor(self)

	self._curViewDatas = nil
end

function FamilyHonorListView:bindEvents()
	FamilyHonorListView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "familyhonorlist")
	end, self)
	self._rankBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.FamilyHonor, 0)
	end, self)
	self._allBtn:AddClickListener(function()
		self:_onClickChoiseBtn(-1)
	end, self)
	self._haveBtn:AddClickListener(function()
		self:_onClickChoiseBtn(1)
	end, self)
	self._notBtn:AddClickListener(function()
		self:_onClickChoiseBtn(0)
	end, self)
	self._notAvailableTog:AddOnValueChanged(function(go, isOn)
		self:_choiseNotAvailableTog()
	end, self)
end

function FamilyHonorListView:unbindEvents()
	FamilyHonorListView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._allBtn:RemoveClickListener()
	self._haveBtn:RemoveClickListener()
	self._notBtn:RemoveClickListener()
	self._notAvailableTog:RemoveOnValueChanged()
end

function FamilyHonorListView:onExit()
	FamilyHonorListView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataNewFamilyHonorRank, self._updataMyFamilyRank, self)
end

function FamilyHonorListView:destroyUI()
	FamilyHonorListView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilyHonorListView:buildUI()
	FamilyHonorListView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._collectTxt = goutil.findChild(leftInfoGo, "collectTxt"):GetComponent(typeof(UIImgNumeralText))
	self._levelTxt3 = goutil.findChildTextComponent(leftInfoGo, "levelGo_3/leveTxt_3")
	self._levelTxt2 = goutil.findChildTextComponent(leftInfoGo, "levelGo_2/leveTxt_2")
	self._levelTxt1 = goutil.findChildTextComponent(leftInfoGo, "levelGo_1/leveTxt_1")
	self._rankBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "rankBtn")
	self._myRankTxt = goutil.findChildTextComponent(leftInfoGo, "myRankTxt")

	local honorListGo = self:getGo("honorListGo")

	self._allBtn = Framework.ButtonAdapter.GetFrom(honorListGo, "allBtn")
	self._allGrop = self._allBtn.gameObject:GetComponent("UIChangeGroup")
	self._haveBtn = Framework.ButtonAdapter.GetFrom(honorListGo, "haveBtn")
	self._haveGrop = self._haveBtn.gameObject:GetComponent("UIChangeGroup")
	self._notBtn = Framework.ButtonAdapter.GetFrom(honorListGo, "notBtn")
	self._notGrop = self._notBtn.gameObject:GetComponent("UIChangeGroup")
	self._notAvailableTog = Framework.ToggleAdapter.GetFrom(honorListGo, "notAvailableTog")
	self._emptyGo = goutil.findChild(honorListGo, "emptyGo")

	self._collectTxt:SetNum(0)

	self._levelTxt3.text = ""
	self._levelTxt2.text = ""
	self._levelTxt1.text = ""
	self._myRankTxt.text = ""

	GameUtil.SetActive(self._emptyGo, false)
end

function FamilyHonorListView:onEnter()
	FamilyHonorListView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataNewFamilyHonorRank, self._updataMyFamilyRank, self)

	self._notAvailableTog.isOn = false

	local settingInfo = FamilyModel.instance:getMyFamilySettingInfo()

	if settingInfo then
		self._familyName = settingInfo.familyName or "无"
	end

	self._choiseNum = nil

	self:_onClickChoiseBtn(-1)
	FamilyHonorController.instance:csRequestFamilyMedalViewRankReq()
end

function FamilyHonorListView:_onClickChoiseBtn(num)
	if self._choiseNum == num then
		return
	end

	self._choiseNum = num

	self:_choiseNotAvailableTog()
	self._collectTxt:SetNum(self._haveCount)

	if self._starInfo[3] then
		self._levelTxt3.text = self._starInfo[3].have .. "/" .. self._starInfo[3].all or "0/0"
	end

	if self._starInfo[2] then
		self._levelTxt2.text = self._starInfo[2].have .. "/" .. self._starInfo[2].all or "0/0"
	end

	if self._starInfo[1] then
		self._levelTxt1.text = self._starInfo[1].have .. "/" .. self._starInfo[1].all or "0/0"
	end

	self:_updataMyFamilyRank()

	if num == -1 then
		self._allGrop:SetState(1)
		self._haveGrop:SetState(0)
		self._notGrop:SetState(0)
	elseif num == 0 then
		self._allGrop:SetState(0)
		self._haveGrop:SetState(0)
		self._notGrop:SetState(1)
	elseif num == 1 then
		self._allGrop:SetState(0)
		self._haveGrop:SetState(1)
		self._notGrop:SetState(0)
	end
end

function FamilyHonorListView:_choiseNotAvailableTog()
	self._allCount, self._haveCount, self._starInfo, self._curViewDatas = FamilyHonorModel.instance:getAllAndHaveHonorInfo(self._choiseNum, self._notAvailableTog.isOn)

	if self._curViewDatas and #self._curViewDatas > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._tableview:ReloadData()
end

function FamilyHonorListView:_updataMyFamilyRank(myRank)
	self._myRankTxt.text = checknumber(myRank) <= 0 and "我的家族上榜：未上榜" or "我的家族上榜：" .. myRank .. "名"
end

function FamilyHonorListView:_getPath()
	return {
		cellPath = "honorListGo/honorItem",
		viewPath = "honorListGo/honorListSR"
	}
end

function FamilyHonorListView:_cellSize()
	return 174, 250
end

function FamilyHonorListView:_updateCell(view, cell, data)
	local levelIma = goutil.findChild(cell, "levelIma"):GetComponent("UIImageSpriteChange")
	local iconImaGo = goutil.findChild(cell, "iconImaGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local lockGo = goutil.findChild(cell, "lockGo")

	GameUtil.asBtn(cell):RemoveClickListener()
	uGuiUtil.clearImage(iconImaGo)

	local info = FamilyHonorModel.instance:getHonorByDefineId(data.id)

	levelIma:SetState(data.level - 1)

	local iconPath = "ui/bigbg/familycallorder/" .. data.icon .. ".png"

	uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, iconPath)

	nameTxt.text = data.name

	local params = {
		isSeeInfo = false,
		gainedTime = -1,
		progress = 0,
		defineId = data.id,
		familyName = self._familyName
	}

	if info then
		GameUtil.SetActive(lockGo, checknumber(info.gainedTime) <= 0)

		params.gainedTime = info.gainedTime
		params.progress = info.progress
	else
		GameUtil.SetActive(lockGo, true)
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		UIStateManager.instance:push(ViewName.FamilyHonorTips, params)
	end, self)
end

return FamilyHonorListView
