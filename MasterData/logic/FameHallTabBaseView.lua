-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/famehall/view/FameHallTabBaseView.lua

module("logic.extensions.famehall.view.FameHallTabBaseView", package.seeall)

local FameHallTabBaseView = class("FameHallTabBaseView", ViewComponent)

function FameHallTabBaseView:ctor()
	FameHallTabBaseView.super.ctor(self)
end

function FameHallTabBaseView:unbindEvents()
	FameHallTabBaseView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnInfo)
end

function FameHallTabBaseView:bindEvents()
	FameHallTabBaseView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
end

function FameHallTabBaseView:buildUI()
	FameHallTabBaseView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._rolePoint_1 = self:getGo("modelCam/rolePoint_1")
	self._seasonTableView = self:getGo("seasonTableview")
	self._seasonTableCell = self:getGo("seasonTableCell")
	self._seasonTableList = ScrollerList.create(self._seasonTableView, self._seasonTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitle = self:getTxt("txtTitle")
	self._txtName = self:getTxt("name/txtName")
	self._txtArea = self:getTxt("area/txtArea")
	self._txtFamily = self:getTxt("family/txtFamily")
	self._txtTips = self:getTxt("tips/txtTips")
	self._btnChange = self:getGo("btnChange")
	self._textChange = self:getTxt("btnChange/bg/text")
	self._customInput = UICustomInput.Get(self._seasonTableView)
	self._con = self:getGo("con")
	self._emptyCon = self:getGo("emptyCon")
	self._btnInfo = self:getGo("con/btnInfo")
	self._rankScoreGo = self:getGo("rankScore")
	self._txtRankScore = self:getTxt("rankScore/txtRankScore")
end

function FameHallTabBaseView:onExit()
	FameHallTabBaseView.super.onExit(self)
	LightMgr.instance:setLightForNormalScene()
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)
	end

	self._avatar = nil
end

function FameHallTabBaseView:onEnter()
	FameHallTabBaseView.super.onEnter(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self:addGEvent(GlobalNotify.PM_FameHallGetInfoRes, self._PM_FameHallGetInfoRes)
	self:_initData()
	self:_refreshView()
end

function FameHallTabBaseView:_initData()
	self._seasonListData = {
		{
			activityId = 1,
			index = 1
		},
		{
			activityId = 2,
			index = 2
		},
		{
			activityId = 3,
			index = 3
		}
	}
	self._curSelectSeason = #self._seasonListData
	self._isInitData = false

	self:_updateData()
end

function FameHallTabBaseView:getTitleName()
	local params = self:getFirstParam()

	return langPara("第%s届%s", GameUtil.getChineseNumber(self._curSelectSeason), params.name)
end

function FameHallTabBaseView:_updateData()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.typeId, self._seasonListData[self._curSelectSeason].activityId)

	self._gender = RoleModel.instance:getGender()
	self._clothes = RoleModel.instance:getClothes() or {}
	self._userId = 0
	self._extParam = ""

	if info and checknumber(info.headInfo.userId) > 0 then
		self._gender = info.gender
		self._clothes = info.clothes or {}
		self._name = info.headInfo.userName
		self._area = info.areaName
		self._family = info.familyName
		self._userId = info.headInfo.userId
		self._extParam = info.extParam
	elseif not self._isInitData then
		FameHallAgent.instance:sendPM_FameHallGetInfoReq(params.typeId, self._seasonListData[self._curSelectSeason].activityId)
	else
		self._name = lang("虚位以待")
		self._area = lang("无")
		self._family = lang("无")
	end

	self._isInitData = true
end

function FameHallTabBaseView:getCellDesc(seasonId)
	return langPara("第%s届", GameUtil.getChineseNumber(seasonId))
end

function FameHallTabBaseView:_refreshView()
	local params = self:getFirstParam()

	self._txtTitle.text = self:getTitleName()
	self._txtName.text = self._name
	self._txtArea.text = self._area
	self._txtFamily.text = string.nilorempty(self._family) and langPara("无") or self._family

	goutil.setActive(self._rankScoreGo, false)
	GameUtil.SetActive(self._seasonTableView, false)
	self._seasonTableList:reloadData(self._seasonListData)
	self._seasonTableList:MoveCellInView(self._curSelectSeason - 1, false)

	if checknumber(self._userId) > 0 then
		local skId = DressModel.instance:getSkeIdByGender(self._gender)
		local avatarMo = DressModel.instance:getAvatarPlayerMo(skId, self._clothes, 0)

		if self._avatar then
			self._avatar:updateByMo(avatarMo)
		else
			self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

			self._avatar:setParent(self._rolePoint_1.transform)
			self._avatar:setLayer(SceneLayer.UI3D_Value)
			self._avatar:updateByMo(avatarMo)
		end
	end

	if self._avatar then
		self._avatar:setVisible(checknumber(self._userId) > 0)
	end

	GameUtil.SetActive(self._con, checknumber(self._userId) > 0)
	GameUtil.SetActive(self._emptyCon, checknumber(self._userId) <= 0)
	GameUtil.SetActive(self._btnChange, #self._seasonListData > 1)

	self._txtTips.text = params.txtTips
	self._textChange.text = self:getCellDesc(self._curSelectSeason)
end

function FameHallTabBaseView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local imgChange = go:GetComponent(ComponentType.UIChangeGroup)

	txtDesc.text = self:getCellDesc(data.index)

	GameUtil.addClickHandler(go, function()
		self:_onClickSeason(data.index)
	end, self)

	if data.index == self._curSelectSeason then
		imgChange:SetState(1)
	else
		imgChange:SetState(0)
	end
end

function FameHallTabBaseView:_clearCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function FameHallTabBaseView:_onClickSeason(seasonId)
	self._curSelectSeason = seasonId
	self._isInitData = false

	self:_updateData()
	self:_refreshView()
end

function FameHallTabBaseView:_onClickChange()
	GameUtil.SetActive(self._seasonTableView, true)
end

function FameHallTabBaseView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._seasonTableView, false)
	end
end

function FameHallTabBaseView:_onClickInfo()
	local params = self:getFirstParam()
	local info = FameHallModel.instance:getInfo(params.tabId, self._seasonListData[self._curSelectSeason].activityId)

	if info and checknumber(info.headInfo.userId) > 0 then
		FriendController.instance:showInfoView(checknumber(info.headInfo.userId), self._btnInfo)
	end
end

function FameHallTabBaseView:_PM_FameHallGetInfoRes()
	self:_updateData()
	self:_refreshView()
end

return FameHallTabBaseView
