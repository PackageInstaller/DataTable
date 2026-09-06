-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilySettingView.lua

module("logic.extensions.family.view.FamilySettingView", package.seeall)

local FamilySettingView = class("FamilySettingView", ViewComponent)

function FamilySettingView:ctor()
	FamilySettingView.super.ctor(self)

	self._addPowerStep = checknumber(FamilyConfig.instance:getCommonValue("MAX_ZDL_STEP"))
	self._addLevelStep = checknumber(FamilyConfig.instance:getCommonValue("PLAYER_LEVEL_STEP"))
end

function FamilySettingView:destroyUI()
	FamilySettingView.super.destroyUI(self)
end

function FamilySettingView:onExitFinished()
	FamilySettingView.super.onExitFinished(self)
end

function FamilySettingView:onEnterFinished()
	FamilySettingView.super.onEnterFinished(self)
end

function FamilySettingView:unbindEvents()
	FamilySettingView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
	self._btnManual:RemoveClickListener()
	self._btnPower:RemoveClickListener()
	self._btnLevel:RemoveClickListener()
	self._btnAddPower:RemoveClickListener()
	self._btnReducePower:RemoveClickListener()
	self._btnAddLevel:RemoveClickListener()
	self._btnReduceLevel:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._btnChangeIcon:RemoveClickListener()
	self._btnModify:RemoveClickListener()
	self._btnCreate:RemoveClickListener()
	self._btnInput:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnIconRule:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnRandom)
end

function FamilySettingView:bindEvents()
	FamilySettingView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnAuto:AddClickListener(function()
		self:_switchVerify(true)
	end)
	self._btnManual:AddClickListener(function()
		self:_switchVerify(false)
	end)
	self._btnPower:AddClickListener(self._onClickPower, self)
	self._btnLevel:AddClickListener(self._onClickLevel, self)
	self._btnAddPower:AddClickListener(function()
		self:_modifyPower(true)
	end)
	self._btnReducePower:AddClickListener(function()
		self:_modifyPower(false)
	end)
	self._btnAddLevel:AddClickListener(function()
		self:_modifyLevel(true)
	end)
	self._btnReduceLevel:AddClickListener(function()
		self:_modifyLevel(false)
	end)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	self._btnChangeIcon:AddClickListener(self._onClickChangeIcon, self)
	self._btnModify:AddClickListener(function()
		self:_onClickButton(false)
	end)
	self._btnCreate:AddClickListener(function()
		self:_onClickButton(true)
	end)
	self._btnInput:AddClickListener(self._onClickInput, self)
	self._btnRule:AddClickListener(function()
		self:_onClickRule(self._isCreate and "familycreate" or "familysetting")
	end)
	self._btnIconRule:AddClickListener(function()
		self:_onClickRule("familyicon")
	end)
	GameUtil.addClickHandler(self._btnRandom, self._onClickBtnRandom, self)
end

function FamilySettingView:onExit()
	FamilySettingView.super.onExit(self)
	removetimer(self._updateTipTime, self)
end

function FamilySettingView:buildUI()
	FamilySettingView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "topleft/txt_title")
	self._closeButton = self:getBtn("topleft/btn_close")
	self._btnHome = self:getBtn("topleft/btn_home")
	self._btnRule = self:getBtn("topleft/btn_rule")
	self._inputField = Framework.InputFieldAdapter.GetFrom(self.mainGO, "right/inputField")
	self._btnInput = self:getBtn("right/btnInput")
	self._tags = ItemGroup.New(self:getGo("right/tags"))

	self._tags:updateWithLen(6, function(item, i)
		local tag = i - 1

		FamilyFacade.instance:updateFamilyTag(item.mainGO, tag)

		item.imgSpriteChange = goutil.findChildComponent(item.mainGO, "imgSpriteChange", "UIImageSpriteChange")
		item.imgColorChange = item.imgSpriteChange:GetComponent("UIImageColorChange")
		item.btn = Framework.ButtonAdapter.GetFrom(item.mainGO, "btnClick")

		item.btn:AddClickListener(function()
			self:_onClickTag(tag)
		end)
	end)

	self._btnAuto = Framework.ButtonAdapter.GetFrom(self.mainGO, "right/btnAuto")
	self._btnManual = Framework.ButtonAdapter.GetFrom(self.mainGO, "right/btnManual")
	self._autoSpriteChange = goutil.findChildComponent(self._btnAuto.gameObject, "image", "UIImageSpriteChange")
	self._manualSpriteChange = goutil.findChildComponent(self._btnManual.gameObject, "image", "UIImageSpriteChange")
	self._autoColorChange = self._autoSpriteChange:GetComponent("UIImageColorChange")
	self._manualColorChange = self._manualSpriteChange:GetComponent("UIImageColorChange")
	self._power = self:getGo("right/power")
	self._btnPower = self:getBtn("right/btnPower")
	self._btnAddPower = Framework.ButtonAdapter.GetFrom(self._power, "btnAdd")
	self._btnReducePower = Framework.ButtonAdapter.GetFrom(self._power, "btnReduce")
	self._txtPower = goutil.findChildTextComponent(self._power, "txtPower")
	self._imgPowerChange = goutil.findChildComponent(self._btnPower.gameObject, "image", "UIImageSpriteChange")
	self._imgPowerColorChange = self._imgPowerChange:GetComponent("UIImageColorChange")
	self._level = self:getGo("right/level")
	self._btnLevel = self:getBtn("right/btnLevel")
	self._btnAddLevel = Framework.ButtonAdapter.GetFrom(self._level, "btnAdd")
	self._btnReduceLevel = Framework.ButtonAdapter.GetFrom(self._level, "btnReduce")
	self._txtLevel = goutil.findChildTextComponent(self._level, "txtLevel")
	self._imgLevelChange = goutil.findChildComponent(self._btnLevel.gameObject, "image", "UIImageSpriteChange")
	self._imgLevelColorChange = self._imgLevelChange:GetComponent("UIImageColorChange")
	self._btnModify = self:getBtn("btnModify")
	self._btnCreate = self:getBtn("btnCreate")
	self._btnChangeIcon = self:getBtn("left/btnChangeIcon")
	self._imgIconChange = goutil.findChildComponent(self.mainGO, "left/headIcon", "UIImageSpriteChange")
	self._txtIconCost = goutil.findChildTextComponent(self.mainGO, "left/txtIconCost")
	self._txtNameCost = goutil.findChildTextComponent(self.mainGO, "right/txtNameCost")
	self._txtTotalCost = goutil.findChildTextComponent(self.mainGO, "txtTotalCost")
	self._iconCost = FamilyConfig.instance:getCostByKey("MODIFY_ICON_ID_GOODS_ID")
	self._txtIconCost.text = self._iconCost
	self._nameCost = FamilyConfig.instance:getCostByKey("MODIFY_FAMILY_NAME_GOODS_ID")
	self._txtNameCost.text = self._nameCost
	self._createCost = FamilyConfig.instance:getCostByKey("CREATE_FAMILY_GOODS_ID")
	self._btnRule = self:getBtn("topleft/btn_rule")
	self._btnIconRule = self:getBtn("left/btn_icon")
	self._tipTime = goutil.findChildTextComponent(self.mainGO, "left/tipTime")
	self._imgpen = self:getGo("right/inputField/imgpen")
	self._btnRandom = self:getGo("right/inputField/btnRandom")
end

function FamilySettingView:onEnter()
	FamilySettingView.super.onEnter(self)

	if FamilyController.instance:isHasFamily() then
		FamilyController.instance:getMyFamilyInfoReq(self._updateAllUI, self)
	else
		self:_updateAllUI()
	end

	settimer(1, self._updateTipTime, self, true)

	local isAble = true
	local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		isAble = false
	end

	self._inputField.input.interactable = isAble

	goutil.setActive(self._btnRandom, not isAble)
	goutil.setActive(self._imgpen, isAble)
end

function FamilySettingView:_updateAllUI()
	self._settingInfo = FamilyExtension_pb.FamilySettings_P()

	local mySettingInfo = FamilyModel.instance:getMyFamilySettingInfo()

	self._isCreate = mySettingInfo == nil

	if mySettingInfo == nil then
		self._settingInfo.iconId = 0
		self._settingInfo.familyName = ""
		self._settingInfo.purpose = 0
		self._settingInfo.needApproval = false
		self._settingInfo.maxZdlLimit = 0
		self._settingInfo.playerLevelLimit = 0
	else
		self._settingInfo.iconId = mySettingInfo.iconId
		self._settingInfo.familyName = mySettingInfo.familyName
		self._settingInfo.purpose = mySettingInfo.purpose
		self._settingInfo.needApproval = mySettingInfo.needApproval
		self._settingInfo.maxZdlLimit = mySettingInfo.maxZdlLimit
		self._settingInfo.playerLevelLimit = mySettingInfo.playerLevelLimit
		self._settingInfo.settingsCdEndMillis = mySettingInfo.settingsCdEndMillis

		goutil.setActive(self._btnRandom, false)
	end

	self._settingInfo.maxZdlLimit = checknumber(self._settingInfo.maxZdlLimit)
	self._settingInfo.playerLevelLimit = checknumber(self._settingInfo.playerLevelLimit)

	self:_updateUI()
	self:_updateTipTime()
end

function FamilySettingView:_updateUI()
	self._txtTitle.text = self._isCreate and "创建家族" or "家族设置"

	goutil.setActive(self._btnModify.gameObject, not self._isCreate)
	goutil.setActive(self._btnCreate.gameObject, self._isCreate)
	goutil.setActive(self._txtIconCost.gameObject, not self._isCreate)
	goutil.setActive(self._txtNameCost.gameObject, not self._isCreate)
	goutil.setActive(self._btnInput.gameObject, not self:_checkModifyCd(true))
	self._inputField:SetText(self._settingInfo.familyName)
	self:_onClickTag(self._settingInfo.purpose)
	self:_switchVerify(self._settingInfo.needApproval ~= true)
	self:_onClickPower(true)
	self:_onClickLevel(true)
	self:_updateIcon()
end

function FamilySettingView:_onClickClose()
	self:close()
end

function FamilySettingView:_onClickTag(i)
	self._settingInfo.purpose = i

	self._tags:updateWithLen(6, function(item, j)
		local state = j == self._settingInfo.purpose + 1 and 1 or 0

		item.imgSpriteChange:SetState(state)
		item.imgColorChange:SetState(state)
	end)
end

function FamilySettingView:_switchVerify(isAuto)
	self._settingInfo.needApproval = not isAuto

	self._autoSpriteChange:SetState(isAuto and 1 or 0)
	self._autoColorChange:SetState(isAuto and 1 or 0)
	self._manualSpriteChange:SetState(isAuto and 0 or 1)
	self._manualColorChange:SetState(isAuto and 0 or 1)
end

function FamilySettingView:_onClickPower(isForce)
	local isPowerLimit = self._settingInfo.maxZdlLimit > 0

	if not isForce then
		isPowerLimit = not isPowerLimit
		self._settingInfo.maxZdlLimit = isPowerLimit and FamilyModel.instance:getCachePower() or 0
	elseif isPowerLimit then
		if not self._settingInfo.maxZdlLimit then
			local power = FamilyModel.instance:getCachePower()

			self._txtPower.text = string.format("%sW", power / 10000)
		end
	end

	self._imgPowerChange:SetState(isPowerLimit and 1 or 0)
	self._imgPowerColorChange:SetState(isPowerLimit and 1 or 0)
	uGuiUtil.setGoGrayState(self._power, not isPowerLimit)
end

function FamilySettingView:_modifyPower(isAdd)
	local power = self._settingInfo.maxZdlLimit

	if power > 0 then
		power = isAdd and power + self._addPowerStep or power - self._addPowerStep

		FamilyModel.instance:setCachePower(power)

		self._settingInfo.maxZdlLimit = FamilyModel.instance:getCachePower()
		self._txtPower.text = string.format("%sW", self._settingInfo.maxZdlLimit / 10000)
	else
		FloatWordMgr.instance:show("请先选择申请条件")
	end
end

function FamilySettingView:_onClickLevel(isForce)
	local isLevelLimit = self._settingInfo.playerLevelLimit > 0

	if not isForce then
		isLevelLimit = not isLevelLimit
		self._settingInfo.playerLevelLimit = isLevelLimit and FamilyModel.instance:getCacheLevel() or 0
	elseif isLevelLimit then
		if not self._settingInfo.playerLevelLimit then
			local showLv = FamilyModel.instance:getCacheLevel()

			self._txtLevel.text = string.format("%s级", showLv)
		end
	end

	self._imgLevelChange:SetState(isLevelLimit and 1 or 0)
	self._imgLevelColorChange:SetState(isLevelLimit and 1 or 0)
	uGuiUtil.setGoGrayState(self._level, not isLevelLimit)
end

function FamilySettingView:_modifyLevel(isAdd)
	local level = self._settingInfo.playerLevelLimit

	if level > 0 then
		level = isAdd and level + self._addLevelStep or level - self._addLevelStep

		FamilyModel.instance:setCacheLevel(level)

		self._settingInfo.playerLevelLimit = FamilyModel.instance:getCacheLevel()
		self._txtLevel.text = self._settingInfo.playerLevelLimit .. "级"
	else
		FloatWordMgr.instance:show("请先选择申请条件")
	end
end

function FamilySettingView:_onValueChanged()
	if not self._isCreate then
		local v = FriendConfig.instance:getCommonValue("NO_RENAME_PERIOD")
		local times = string.split(v, "#")

		if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
			FloatWordMgr.instance:show("改名功能正在进行技术维护，具体开放时间请留意公告！")

			local mySettingInfo = FamilyModel.instance:getMyFamilySettingInfo()

			if mySettingInfo then
				self._inputField:SetText(mySettingInfo.familyName)
			else
				self._inputField:SetText(self._settingInfo.familyName)
			end

			return
		end
	end

	local value = self._inputField:GetText()
	local text, len = StringUtil.getLimitStr(value, 14)

	self._inputField:SetText(text)

	self._settingInfo.familyName = text

	self:_checkTotalCost()
end

function FamilySettingView:_onClickButton(isCreate)
	local text = self._inputField:GetText()

	if string.nilorempty(text) then
		FloatWordMgr.instance:show("家族名不能为空")

		return
	end

	if not MaterialModel.instance:IsEnough(MatType.Diamond, 0, checknumber(self._txtTotalCost.text)) then
		MaterialMgr.openGetSource(MatType.Diamond, MatType.Diamond_Binding)

		return
	end

	if not isCreate then
		local mySettingInfo = FamilyModel.instance:getMyFamilySettingInfo()

		FamilyController.instance:modifySettingReq(self._settingInfo, self._onModifySuccess, self)
	else
		local title = "提示"
		local icon = TipsFacade.instance:getContentMatStr(string.format("%s:%s", MatType.Diamond, 2), 50, -10, true)
		local content = string.format("是否消耗%s%s，创建[%s]", icon, self._createCost, text)

		TipsFacade.instance:openPopupWindow(title, content, function()
			FamilyController.instance:createFamilyReq(self._settingInfo, self._onCreateSuccess, self)
		end)
	end
end

function FamilySettingView:_updateIcon()
	self._imgIconChange:SetState(self._settingInfo.iconId)
	self:_checkTotalCost()
end

function FamilySettingView:_checkTotalCost()
	local mySettingInfo = FamilyModel.instance:getMyFamilySettingInfo()
	local total = 0

	if mySettingInfo then
		if mySettingInfo.familyName ~= self._settingInfo.familyName then
			total = total + self._nameCost
		end

		if mySettingInfo.iconId ~= self._settingInfo.iconId then
			total = total + self._iconCost
		end
	else
		total = self._createCost
	end

	self._txtTotalCost.text = total
end

function FamilySettingView:_onClickChangeIcon()
	if self:_checkModifyCd() then
		UIStateManager.instance:open(ViewName.FamilyIcon, self._settingInfo, function(iconId)
			self._settingInfo.iconId = iconId

			self:_updateIcon()
		end)
	end
end

function FamilySettingView:_updateTipTime()
	local leftTime = 0

	if self._settingInfo then
		local leftTime = checknumber(self._settingInfo.settingsCdEndMillis) / 1000 - ServerTime.now()

		if leftTime > 0 then
			local hour = math.floor(leftTime / 3600)
			local sec = leftTime % 60
			local min = math.floor(leftTime % 3600 / 60)

			self._tipTime.text = string.format("%02d: %02d: %02d", hour, min, sec)
		end
	end

	goutil.setActive(self._tipTime.gameObject, leftTime > 0)
	goutil.setActive(self._btnInput.gameObject, leftTime > 0)
end

function FamilySettingView:_checkModifyCd(tips)
	if self._isCreate or ServerTime.now() >= checknumber(self._settingInfo.settingsCdEndMillis) / 1000 then
		return true
	else
		if not tips then
			FloatWordMgr.instance:show("7天内只能更改名称、更改头像1次")
		end

		return false
	end
end

function FamilySettingView:_onCreateSuccess()
	FloatWordMgr.instance:show("创建成功")
	UIStateManager.instance:_clearExistState(ViewName.FamilyList)
	FamilyController.instance:setFamilyViewTab(1)
	FamilySceneController.instance:enterScene()
end

function FamilySettingView:_onModifySuccess()
	FloatWordMgr.instance:show("修改成功")
	self:close()
end

function FamilySettingView:_onClickInput()
	self:_checkModifyCd()
end

function FamilySettingView:_onClickRule(key)
	UIStateManager.instance:open(ViewName.RulesView, key)
end

function FamilySettingView:getRandomName()
	local name = ""
	local id = 3
	local cfg = LoginConfig.instance:getRule(id)
	local arr = string.split(cfg.index, "#")

	for i = 1, 3 do
		local t = LoginConfig.instance:getCfgsByGroup(checknumber(arr[i]))

		if t and #t > 0 then
			name = name .. t[math.random(#t)].content
		end
	end

	local realLen = self:getNameRealLen()

	if realLen > 14 then
		return self:getRandomName()
	else
		return name
	end
end

function FamilySettingView:getNameRealLen(content)
	if string.nilorempty(content) then
		content = self._inputField:GetText()
	end

	local result = StringUtil.utf8split(content)
	local isAllNum, isAllUnderLine = true, true

	for _, v in ipairs(result) do
		isAllNum = isAllNum and v >= "0" and v <= "9"
		isAllUnderLine = isAllUnderLine and v == "_"
	end

	return #result, isAllNum, isAllUnderLine
end

function FamilySettingView:_onClickBtnRandom()
	self._inputField:SetText(self:getRandomName())
end

return FamilySettingView
