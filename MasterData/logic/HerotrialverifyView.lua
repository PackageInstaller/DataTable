-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/HerotrialverifyView.lua

module("logic.extensions.herotrial.view.HerotrialverifyView", package.seeall)

local HerotrialverifyView = class("HerotrialverifyView", ViewComponent)

function HerotrialverifyView:ctor()
	HerotrialverifyView.super.ctor(self)
end

function HerotrialverifyView:buildUI()
	HerotrialverifyView.super.buildUI(self)

	self.btnClose = self:getBtn("btnClose")
	self.btnVerify = self:getBtn("btnVerify")
	self._content = self:getGo("content")
	self._verifyCell = self:getGo("verifyCell")
	self._pet = goutil.findChild(self.mainGO, "pet/iconHead")
	self._txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "curEffect/txtVerifyEffect")
	self.txtPetName = goutil.findChildTextComponent(self.mainGO, "pet/txtPetName")
	self.imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "curEffect/imgEffect")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "pet/txtPower")
	self._cellList = {}
	self.ScrollView = self:getGo("ScrollView")
	self.scrollList = ScrollerList.create(self.ScrollView, self._verifyCell, GameUtil.handler(self.updateCell, self))
end

function HerotrialverifyView:bindEvents()
	HerotrialverifyView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self.btnVerify:AddClickListener(self._onAddPet, self)
end

function HerotrialverifyView:unbindEvents()
	HerotrialverifyView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnVerify:RemoveClickListener()
end

function HerotrialverifyView:destroyUI()
	HerotrialverifyView.super.destroyUI(self)
end

function HerotrialverifyView:onEnter()
	HerotrialverifyView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.HeroTrialVerifySuccess, self._refresh, self)
	self:_refresh()
end

function HerotrialverifyView:onEnterFinished()
	HerotrialverifyView.super.onEnterFinished(self)
end

function HerotrialverifyView:onExit()
	MaterialMgr.resetAll(self._pet)

	for k, v in ipairs(self._cellList) do
		goutil.destroy(v)
	end

	table.clear(self._cellList)
	GlobalDispatcher:removeListener(GlobalNotify.HeroTrialVerifySuccess, self._refresh, self)
	self.imgEffect:ClearImage()
	HerotrialverifyView.super.onExit(self)
	self.scrollList:dispose()
end

function HerotrialverifyView:onExitFinished()
	HerotrialverifyView.super.onExitFinished(self)
end

function HerotrialverifyView:_refresh()
	local activityId = HerotrialModel.instance:getActivityId()
	local higestVerifiedZdl = HerotrialModel.instance:getHigestVerifiedZdl()
	local verifyCfg = HerotrialController.instance:getCurVerifyPlan(higestVerifiedZdl)
	local color = "11a568"

	if verifyCfg then
		local verifyName = string.format(verifyCfg.name or "", color)

		if verifyCfg then
			local verifyDes = string.format(verifyCfg.des or "", color)

			self._txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)

			local htCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)

			MaterialMgr.setCell(MatType.Pet, htCfg.verifyRaceId, self._pet)

			self.txtPetName.text = CharacterConfig.instance:getPetCo(htCfg.verifyRaceId).name

			local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
			local bossBuff = plans[1]

			if verifyCfg then
				bossBuff = verifyCfg.bossBuff
				self._curLevel = verifyCfg.level
			end

			local tempStr = string.split(bossBuff, ":")
			local buffId = tempStr[1]
			local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

			self.imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))

			self._txtPower.text = "已验证最佳战力：" .. higestVerifiedZdl

			local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
			local plansArr = {}

			for k, v in pairs(plans) do
				table.insert(plansArr, v)
			end

			table.sort(plansArr, function(a, b)
				return a.level < b.level
			end)
			self.scrollList:reloadData(plansArr)

			local index = 1

			if plansArr and #plansArr > 5 then
				for i = 1, #plansArr do
					if plansArr[i] and plansArr[i].level == self._curLevel then
						index = i

						break
					end
				end
			end

			self.scrollList:MoveCellInView(index - 1, false)
		end
	end
end

function HerotrialverifyView:_onAddPet()
	local function onSeletCallBack(petId)
		HerotrialController.instance:verify(petId)
	end

	local activityId = HerotrialModel.instance:getActivityId()
	local raceId = HerotrialConfig.instance:getHeroTrialActivity(activityId).verifyRaceId

	local function filterFunc(petMo)
		if petMo.raceId == raceId then
			return true
		end

		return false
	end

	local activityId = HerotrialModel.instance:getActivityId()
	local htCfg = HerotrialConfig.instance:getHeroTrialActivity(activityId)
	local name = CharacterConfig.instance:getPetCo(htCfg.verifyRaceId).name
	local strTitle = "请选择验证精灵" .. name

	PetSelectController.instance:OpenView(true, strTitle, filterFunc, onSeletCallBack, nil)
end

function HerotrialverifyView:_setCell(cell, verifyCfg)
	GameUtil.SetActive(cell, true)

	local goBG = goutil.findChild(cell, "onBg")

	goBG.gameObject:SetActive(verifyCfg.level == self._curLevel)

	local txtPower = goutil.findChildTextComponent(cell, "txtPower")

	txtPower.text = tostring(verifyCfg.leftZdl)

	local txtVerifyEffect = goutil.findChildTextComponent(cell, "txtVerifyEffect")
	local color = "60ee85"
	local verifyName = string.format(verifyCfg.name, color)
	local verifyDes = string.format(verifyCfg.des, color)

	txtVerifyEffect.text = string.format("%s     %s", verifyName, verifyDes)
end

function HerotrialverifyView:updateCell(view, cell, data)
	self:_setCell(cell, data)
end

return HerotrialverifyView
