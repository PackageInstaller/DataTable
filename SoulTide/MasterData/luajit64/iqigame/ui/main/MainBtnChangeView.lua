-- chunkname: @IQIGame\\UI\\Main\\MainBtnChangeView.lua

local m = {
	nextIndex = 1,
	currentSelect = 1,
	haveOathBg = false,
	isOpen = false,
	lastTime = 0,
	showCount = 1,
	haveSpineBg = false
}
local GirlOnDutySaveData = require("IQIGame.Module.Girl.GirlOnDutySaveData")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.BtnOathLabel, MainUIApi:GetString("BtnOathTitle"))
	UGUIUtil.SetText(self.BtnSpineLabel, MainUIApi:GetString("BtnSpineTitle"))
	UGUIUtil.SetText(self.BtnLive2DLabel, MainUIApi:GetString("BtnLive2DTitle"))

	self.tweenPosition = self.Sort:GetComponent("TweenPosition")
	self.startPos = Vector3.New(self.tweenPosition.from.x, self.tweenPosition.from.y, self.tweenPosition.from.z)
	self.endPos = Vector3.New(self.tweenPosition.to.x, self.tweenPosition.to.y, self.tweenPosition.to.z)
	self.tweenSpeed = self.tweenPosition.duration

	function self.delegateBtnOath()
		self:OnBtnOath()
	end

	function self.delegateBtnSpine()
		self:OnBtnSpine()
	end

	function self.delegateBtnLive2D()
		self:OnBtnLive2D()
	end

	function self.delegateBtnNow()
		self:OnBtnNow()
	end

	function self.delegateBtnCloseSort()
		self:OnBtnCloseSort()
	end

	function self.delegateBtnSwitch()
		self:OnBtnSwitch()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnOath:GetComponent("Button").onClick:AddListener(self.delegateBtnOath)
	self.BtnSpine:GetComponent("Button").onClick:AddListener(self.delegateBtnSpine)
	self.BtnLive2D:GetComponent("Button").onClick:AddListener(self.delegateBtnLive2D)
	self.BtnNow:GetComponent("Button").onClick:AddListener(self.delegateBtnNow)
	self.BtnCloseSort:GetComponent("Button").onClick:AddListener(self.delegateBtnCloseSort)
	self.BtnSwitch:GetComponent("Button").onClick:AddListener(self.delegateBtnSwitch)
end

function m:RemoveListener()
	self.BtnOath:GetComponent("Button").onClick:RemoveListener(self.delegateBtnOath)
	self.BtnSpine:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSpine)
	self.BtnLive2D:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLive2D)
	self.BtnNow:GetComponent("Button").onClick:RemoveListener(self.delegateBtnNow)
	self.BtnCloseSort:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCloseSort)
	self.BtnSwitch:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSwitch)
end

function m:OnBtnOath()
	self:SelectType(3)
end

function m:OnBtnSpine()
	self:SelectType(2)
end

function m:OnBtnLive2D()
	self:SelectType(1)
end

function m:OnBtnSwitch()
	local nowTime = PlayerModule.GetServerTime()
	local CD = MainUIApi:GetString("BtnSwitchCD")

	if CD > nowTime - self.lastTime then
		return
	end

	self.lastTime = nowTime

	local isOpen, rotateList = RandomSecretaryModule.GetRandomDressUpRotateList()
	local dressUpRotateList = self:RefreshDressUpRotateList(rotateList)

	if isOpen and #dressUpRotateList > 0 then
		local randomIndex = math.random(1, #dressUpRotateList)
		local nextCid = dressUpRotateList[randomIndex]
		local currentSoulCid = SoulModule.curSoulData.soulCid
		local nextSoulCid = CfgRandomSecretaryTable[nextCid].SoulId
		local dressID

		if nextSoulCid ~= currentSoulCid and nextSoulCid > 0 then
			SoulModule.SetCandidateSoul(nextSoulCid)
		end

		if CfgRandomSecretaryTable[nextCid].SecretaryType ~= Constant.GirlOnDutyShowType.ShowType_Oath then
			local IsWore = DressModule.CheckDressIsWore(CfgRandomSecretaryTable[nextCid].Dress)

			if not IsWore then
				dressID = CfgRandomSecretaryTable[nextCid].Dress

				DressModule.ReqWearDress(CfgRandomSecretaryTable[nextCid].Dress)
			end
		end

		PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MainCity_Spine_BG, CfgRandomSecretaryTable[nextCid].SecretaryType)
		self:ChangeGirlOnDuty(nextSoulCid, CfgRandomSecretaryTable[nextCid].SecretaryType, dressID)
	end

	self:SetBtnOnDuty()
end

function m:ChangeGirlOnDuty(soulCid, type, dressID)
	if soulCid ~= 0 then
		self.tweenPosition = TweenPosition.Begin(self.Sort, self.tweenSpeed, self.startPos)
		self.isOpen = false

		self:CheckGirlOnDuty(soulCid, type, dressID)

		local timer = Timer.New(function()
			EventDispatcher.Dispatch(EventID.SoulSelected, soulCid)
			SoulModule.ReqSoulChanged(soulCid)
			EventDispatcher.Dispatch(EventID.SoulChanged, soulCid)
		end, 1)

		timer:Start()
	end
end

function m:CheckGirlOnDuty(soulCid, type, dressID)
	self.currentSelect = type

	local soulData = SoulModule.GetSoulData(soulCid)

	self.haveSpineBg = false

	if dressID ~= nil then
		if CfgSoulResTable[CfgDressTable[dressID].SoulResID].UISpineId > 0 then
			self.haveSpineBg = true
		end
	elseif soulData:GetCfgSoulRes2D().UISpineId > 0 then
		self.haveSpineBg = true
	end

	self.haveOathBg = false

	local isOathActivate = soulData.oathActivation

	if isOathActivate then
		local cfgSoulMarry = GirlModule.GetSoulOathData(soulCid)

		if cfgSoulMarry then
			self.haveOathBg = cfgSoulMarry.IsNewWhisper
		end
	end

	self.showCount = 1
	self.isOpen = false

	if self.haveOathBg then
		self.showCount = self.showCount + 1
	end

	if self.haveSpineBg then
		self.showCount = self.showCount + 1
	end

	if self.currentSelect == Constant.GirlOnDutyShowType.ShowType_Spine and not self.haveSpineBg then
		self.currentSelect = Constant.GirlOnDutyShowType.ShowType_LIVE2D
	end

	if self.currentSelect == Constant.GirlOnDutyShowType.ShowType_Oath and not self.haveOathBg then
		self.currentSelect = Constant.GirlOnDutyShowType.ShowType_LIVE2D
	end

	self.root:ChangeBG(self.currentSelect, self.haveSpineBg, self.haveOathBg)
	self:UpDateView()
	self:SetBtnNow()
end

function m:SelectType(type)
	self.tweenPosition = TweenPosition.Begin(self.Sort, self.tweenSpeed, self.startPos)
	self.isOpen = false

	self.root:ChangeBG(type, self.haveSpineBg, self.haveOathBg)

	self.currentSelect = type

	self:UpDateView()
	self:SetBtnNow()
end

function m:OnBtnNow()
	if self.showCount > 1 then
		self.tweenPosition = TweenPosition.Begin(self.Sort, self.tweenSpeed, self.endPos)
		self.isOpen = true

		self:UpDateView()
	end
end

function m:UpDateView()
	self.BtnOath:SetActive(self.haveOathBg and self.currentSelect ~= 3)
	self.BtnSpine:SetActive(self.haveSpineBg and self.currentSelect ~= 2)
	self.BtnLive2D:SetActive(self.currentSelect ~= 1)
	self.BtnCloseSort:SetActive(self.isOpen)
	self:SetBtnOnDuty()
end

function m:SetBtnOnDuty()
	local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.GIRL_ON_DUTY)
	local isOpen, roleDataList = RandomSecretaryModule.GetRandomDressUpRotateList()
	local dataList = self:RefreshDressUpRotateList(roleDataList)

	self.BtnSwitch:SetActive(result and isOpen and #dataList >= 1)
end

function m:RefreshDressUpRotateList(dressUpRotateList)
	local tab = {}
	local dressID = SoulModule.curSoulData.dressCid2D
	local soulID = SoulModule.curSoulData.soulCid
	local showBGType = self.root.showBGType
	local randomSecretaryCid

	for i, v in pairsCfg(CfgRandomSecretaryTable) do
		if showBGType == Constant.GirlOnDutyShowType.ShowType_Oath then
			if v.SoulId == soulID and v.SecretaryType == Constant.GirlOnDutyShowType.ShowType_Oath then
				randomSecretaryCid = v.Id
			end
		elseif v.SoulId == soulID and v.Dress == dressID and v.SecretaryType == showBGType then
			randomSecretaryCid = v.Id
		end
	end

	for i, v in pairs(dressUpRotateList) do
		if v ~= randomSecretaryCid then
			table.insert(tab, v)
		end
	end

	return tab
end

function m:SetBtnNow()
	if self.currentSelect == 2 then
		UGUIUtil.SetText(self.BtnNowLabel, MainUIApi:GetString("BtnSpineTitle"))
	elseif self.currentSelect == 3 then
		UGUIUtil.SetText(self.BtnNowLabel, MainUIApi:GetString("BtnOathTitle"))
	else
		UGUIUtil.SetText(self.BtnNowLabel, MainUIApi:GetString("BtnLive2DTitle"))
	end

	self.BtnNow:SetActive(self.showCount > 1)
end

function m:OnBtnCloseSort()
	self.tweenPosition = TweenPosition.Begin(self.Sort, self.tweenSpeed, self.startPos)
	self.isOpen = false

	self:UpDateView()
end

function m:Open(type, haveSpineBg, haveOathBg)
	self.tweenPosition = TweenPosition.Begin(self.Sort, self.tweenSpeed, self.startPos)

	self.View:SetActive(true)

	self.showCount = 1
	self.haveOathBg = haveOathBg
	self.currentSelect = type
	self.isOpen = false

	if haveOathBg then
		self.showCount = self.showCount + 1
	elseif self.currentSelect == 3 then
		self.currentSelect = 1
	end

	self.haveSpineBg = haveSpineBg

	if haveSpineBg then
		self.showCount = self.showCount + 1
	elseif self.currentSelect == 2 then
		self.currentSelect = 1
	end

	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.MainCity_Spine_BG, self.currentSelect)

	self.nextIndex = GirlModule.periodOfTime

	self:UpDateView()
	self:SetBtnNow()
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
