-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/CreateRoleView.lua

module("logic.extensions.login.view.CreateRoleView", package.seeall)

local CreateRoleView = class("CreateRoleView", ViewComponent)

function CreateRoleView:bindEvents()
	self._btnMale:AddClickListener(function()
		self:_onClickSex(true)
	end, self)
	self._btnFemale:AddClickListener(function()
		self:_onClickSex(false)
	end, self)

	if self._btnBack then
		self._btnBack:AddClickListener(function()
			self:_onClickBack()
		end, self)
	end
end

function CreateRoleView:unbindEvents()
	self._btnMale:RemoveClickListener()
	self._btnFemale:RemoveClickListener()

	if self._btnBack then
		self._btnBack:RemoveClickListener()
	end
end

function CreateRoleView:buildUI()
	self._btnBack = self:getBtn("btnBack")

	if self._btnBack then
		self._btnBack.gameObject:SetActive(false)
	end

	self._btnMale = self:getBtn("btnMale")
	self._btnFemale = self:getBtn("btnFemale")
	self.maleGo = self:getGo("btnMale/Mark")
	self.femaleGo = self:getGo("btnFemale/Mark")
	self._imgLogin = goutil.findChildComponent(self.mainGO, "btnLogin", "Image")
	self._goNaming = self:getGo("goNaming")
end

function CreateRoleView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FinishCreateRoleSelGenderAnim, self._onFinishCreateRoleSelGenderAnim, self)
	GlobalDispatcher:addListener(GlobalNotify.CreateRoleSelSceneGender, self._onCreateRoleSelSceneGender, self)

	CreateRoleView._selectedSex = -1

	local param = self:getOpenParam()

	if param and param[1] then
		CreateRoleView._selectedSex = checknumber(param[1])
	end

	self._isPlayingSelGenderAnim = false

	local sex = CreateRoleView._selectedSex

	goutil.setActive(self.maleGo.gameObject, sex == GameEnum.Gender.Male)
	goutil.setActive(self.femaleGo.gameObject, sex == GameEnum.Gender.Female)
	goutil.setActive(self._goNaming, sex >= 0)
	self:localNotify("createRoleSex", CreateRoleView._selectedSex)

	if rescache.resLoadMode == Framework.ResourceLoadMode.RemoteAssetBundle and BootstrapLauncher.setSleepTimeBetweenGroup then
		BootstrapLauncher.instance:setSleepTimeBetweenGroup(2, 1)
	end
end

function CreateRoleView:_updateUIState(sex)
	local preSex = CreateRoleView._selectedSex

	sex = checknumber(sex)

	GlobalDispatcher:dispatch(GlobalNotify.PlayCreateRoleSelGenderAnim, preSex, sex)

	if CreateRoleView._selectedSex == sex then
		return
	end

	CreateRoleView._selectedSex = sex

	goutil.setActive(self.maleGo.gameObject, sex == GameEnum.Gender.Male)
	goutil.setActive(self.femaleGo.gameObject, sex == GameEnum.Gender.Female)
	goutil.setActive(self._goNaming, sex >= 0)
	self:localNotify("createRoleSex", CreateRoleView._selectedSex)

	self._isPlayingSelGenderAnim = true
end

function CreateRoleView:_onClickBack()
	if self._btnBack then
		self._btnBack.gameObject:SetActive(false)
	end

	self:_updateUIState(-1)
end

function CreateRoleView:_onClickSex(isMale)
	if self._btnBack then
		self._btnBack.gameObject:SetActive(true)
	end

	if isMale then
		self:_updateUIState(1)
	else
		self:_updateUIState(0)
	end
end

function CreateRoleView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CreateRoleSelSceneGender, self._onCreateRoleSelSceneGender, self)
	GlobalDispatcher:removeListener(GlobalNotify.FinishCreateRoleSelGenderAnim, self._onFinishCreateRoleSelGenderAnim, self)
end

function CreateRoleView:onExitFinished()
	LightMgr.instance:setLightForNormalScene(true)
end

function CreateRoleView:_onFinishCreateRoleSelGenderAnim()
	self._isPlayingSelGenderAnim = false
end

function CreateRoleView:_onCreateRoleSelSceneGender(gender)
	self:_onClickSex(gender == GameEnum.Gender.Male)
end

return CreateRoleView
