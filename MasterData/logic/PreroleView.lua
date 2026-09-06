-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/PreroleView.lua

module("logic.extensions.login.view.PreroleView", package.seeall)

local PreroleView = class("PreroleView", ViewComponent)

function PreroleView:ctor()
	PreroleView.super.ctor(self)
end

function PreroleView:buildUI()
	PreroleView.super.buildUI(self)

	self._drag = Framework.UIDragTrigger.Get(self:getGo("Drag"))

	local _Nego_Middle = self:getGo("Nego_Middle")

	self._Nego_Character = goutil.findChild(_Nego_Middle, "Nego_Base/Nego_Character").gameObject
	self._Nego_ClickCharacter = goutil.findChild(_Nego_Middle, "Nego_Base/Nego_ClickCharacter").gameObject
	self._Btn_Left = self:getGo("Nego_Middle/Nego_UI/Btn_Left")
	self._Btn_Right = self:getGo("Nego_Middle/Nego_UI/Btn_Right")
	self._leftLp = self._Btn_Left:GetComponent("UILongPressed")
	self._rightLp = self._Btn_Right:GetComponent("UILongPressed")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._rolePoint = goutil.findChild(self._modelCam, "rolePoint")
	self._goRoles = {}
	self._resRoles = {}
	self.txtGender = self:getTxt("bgGender/txt")
	self.txtName = self:getTxt("bgName/txt")
	self.btnStart = self:getGo("btnStart")
end

function PreroleView:bindEvents()
	PreroleView.super.bindEvents(self)
	self:addClickEvent(self._Btn_Right, function()
		self:onRoleTrun(2)
	end)
	self:addClickEvent(self._Btn_Left, function()
		self:onRoleTrun(-2)
	end)
	self.addClickEvent(self, self.btnStart, self.onStartClick, self)
	self._rightLp:AddToggledListener(function(tar, isUp)
		self:onRoleTrun(2)
	end, self)
	self._leftLp:AddToggledListener(function(tar, isUp)
		self:onRoleTrun(-2)
	end, self)
end

function PreroleView:unbindEvents()
	PreroleView.super.unbindEvents(self)
	self:rmAllClickEvent()
end

function PreroleView:destroyUI()
	PreroleView.super.destroyUI(self)

	if self._avatar then
		self._avatar:removeListener(Avatar.OnAvatarLoaded, self._onAvatarLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function PreroleView:onEnter()
	PreroleView.super.onEnter(self)
	GlobalDispatcher:addListener(PlayerAgent.CreatePlayerRes, self._onCreatePlayerRes, self)
	Framework.TransformUtil.SetLocalRotation(self._rolePoint.transform, 0, 180, 0)

	self._goRoles = {}
	self._resRoles = {}

	self:setRoleView3()
end

function PreroleView:onEnterFinished()
	PreroleView.super.onEnterFinished(self)
end

function PreroleView:onExit()
	PreroleView.super.onExit(self)
	GlobalDispatcher:removeListener(PlayerAgent.CreatePlayerRes, self._onCreatePlayerRes, self)
end

function PreroleView:onExitFinished()
	PreroleView.super.onExitFinished(self)
end

function PreroleView:_onCreatePlayerRes(status, msg)
	if msg.erasePreCreatePlayerInfoIfExist then
		RoleModel.instance:onSetPreCreatePlayerInfo(nil)

		if status < 0 then
			TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("您在预创角时的角色名有些字不太合适喔，请重新起名。"))
		end
	end

	self:close()
end

function PreroleView:setRoleView3()
	self._drag:AddDragListener(self._onDrag, self)

	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		self._avatar:setParent(self._rolePoint.transform)
		self._avatar:setLayer(SceneLayer.UI_Value)
		self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	end

	self.txtName.text = ""
	self.txtGender.text = ""

	local info = RoleModel.instance.PreCreatePlayerInfo
	local gender = GameEnum.Gender.Female

	if info then
		self.txtName.text = langPara("奥奇名：%s", tostring(info.userName))

		if checknumber(info.gender) == 0 then
			self.txtGender.text = lang("性别：女")
		else
			self.txtGender.text = lang("性别：男")
			gender = GameEnum.Gender.Male
		end
	end

	local avatarMo = DressModel.instance:getAvatarMoWithDefaultSuit(gender)

	self._avatar:updateByMo(avatarMo)
end

function PreroleView:_onAvatarLoaded()
	return
end

function PreroleView:_onDrag(eventData)
	self:onRoleTrun(eventData.delta.x)
end

function PreroleView:onRoleTrun(deltaX)
	local localRotation = Quaternion.Euler(0, -0.5 * deltaX * 1, 0) * self._rolePoint.transform.localRotation
	local eulerAngles = localRotation.eulerAngles

	Framework.TransformUtil.SetLocalRotation(self._rolePoint.transform, 0, eulerAngles.y, 0)
end

function PreroleView:onStartClick()
	local info = RoleModel.instance.PreCreatePlayerInfo

	if info then
		RoleController.instance:createPlayerName(tostring(info.userName), checknumber(info.gender), self._checkUpdateTips, self)
	end
end

function PreroleView:addClickEvent(go, handler, handlerObj)
	self.btnList = self.btnList or {}

	if go then
		local btn = GameUtil.asBtn(go)

		btn:AddClickListener(handler, handlerObj)
		table.insert(self.btnList, btn)
	end
end

function PreroleView:rmAllClickEvent()
	for i, btn in ipairs(self.btnList) do
		btn:RemoveClickListener()
	end

	self.btnList = nil
end

return PreroleView
