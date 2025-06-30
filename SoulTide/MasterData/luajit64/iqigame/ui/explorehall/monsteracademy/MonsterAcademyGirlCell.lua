-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyGirlCell.lua

local m = {
	monsterGirlStarPool = {}
}
local MonsterAcademyGirlStarCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyGirlStarCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.PowerLabel, MonsterAcademyMoodUIApi:GetString("PowerLabel"))
	UGUIUtil.SetText(self.BtnPhoneLabel, MonsterAcademyMoodUIApi:GetString("BtnPhoneLabel"))
	UGUIUtil.SetText(self.TextRelation, MonsterAcademyMoodUIApi:GetString("TextRelation"))
	UGUIUtil.SetText(self.LockNoticeText, MonsterAcademyMoodUIApi:GetString("LockNoticeText"))
	UGUIUtil.SetText(self.TextOpen, MonsterAcademyMoodUIApi:GetString("TextOpen"))
	UGUIUtil.SetText(self.BtnMessageLabel, MonsterAcademyMoodUIApi:GetString("BtnMessageLabel"))

	function self.delegateBtnPhone()
		self:OnBtnPhone()
	end

	function self.delegateBtnMessage()
		self:OnBtnMessage()
	end

	function self.DelegateSendMessageResult(messageId, girlId)
		self:OnSendMessageResult(messageId, girlId)
	end

	self.monsterGirlStarPool = {}

	for i = 1, 5 do
		local starCell = MonsterAcademyGirlStarCell.New(self["Star" .. i], i)

		self.monsterGirlStarPool[i] = starCell
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnPhone:GetComponent("Button").onClick:AddListener(self.delegateBtnPhone)
	self.BtnMessage:GetComponent("Button").onClick:AddListener(self.delegateBtnMessage)
	EventDispatcher.AddEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
end

function m:RemoveListener()
	self.BtnPhone:GetComponent("Button").onClick:RemoveListener(self.delegateBtnPhone)
	self.BtnMessage:GetComponent("Button").onClick:RemoveListener(self.delegateBtnMessage)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademySendMessageResultEvent, self.DelegateSendMessageResult)
end

function m:SetData(data)
	self.girlData = data

	self:UpdateView()
end

function m:UpdateView()
	self.PhoneRed:SetActive(false)
	self.MessageRed:SetActive(false)
	self.MoodNode:SetActive(true)
	self.ImgBG:SetActive(true)

	if self.girlData then
		self.LockView:SetActive(not self.girlData.unLock)
		self.NormalView:SetActive(self.girlData.unLock)
		self.BtnPhone:SetActive(true)
		UGUIUtil.SetText(self.PowerText, self.girlData.favor)
		UGUIUtil.SetText(self.View2NameText, self.girlData.cfgInfo.Name)

		local favorStage, LoveStage = self.girlData:GetGirlStage()

		UGUIUtil.SetText(self.TextRelationValue, LoveStage)

		local path = UIGlobalApi.GetImagePath(self.girlData.cfgInfo.HeadIcon)

		AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))

		for i, v in pairs(self.monsterGirlStarPool) do
			local num, maxNum = self:GetPerValue(i)

			v:SetData(num, maxNum)
		end

		local funDataTable = self.girlData:GetGirlFunctionBySubType({
			MonsterAcademyConstant.FunctionSubType.FunctionSubType_Telephone,
			MonsterAcademyConstant.FunctionSubType.FunctionSubType_Notice
		})
		local show = false

		if #funDataTable == 1 and funDataTable[1].cfgFunction.FunctionSubType ~= 11 then
			show = true
		end

		self.PhoneRed:SetActive(show)

		local showMessageRed = self.girlData:IsNextMessage()

		self.MessageRed:SetActive(showMessageRed)
		self.BtnPhone:GetComponent("GrayComponent"):SetGray(not self.girlData.unLockPhone)
		self.BtnMessage:GetComponent("GrayComponent"):SetGray(not self.girlData.unLockPhone)
		self.TextOpen:SetActive(not self.girlData.cfgInfo.IsMarry)
		UGUIUtil.SetText(self.TextTest, "好感度：" .. self.girlData.favor .. "\n阶段：" .. favorStage .. "\n描述：" .. LoveStage)

		if GameEntry.Base.DevMode then
			self.TextTest:SetActive(true)
		else
			self.TextTest:SetActive(false)
		end

		if self.girlData.cfgInfo.GirlType == 2 then
			self.BtnPhone:SetActive(false)
			self.MoodNode:SetActive(false)
			self.ImgBG:SetActive(false)
		end
	end
end

function m:OnSendMessageResult(messageId, girlId)
	if self.girlData and girlId == self.girlData.cfgID then
		self.girlData = MonsterAcademyModule.girlDic[girlId]

		self:UpdateView()
	end
end

function m:GetPerValue(index)
	local num = 0
	local maxNum = 0
	local tab = {}

	for i, v in pairsCfg(CfgGalgameMonsterGirlFavorTable) do
		if v.SoulID == self.girlData.cfgID then
			tab[v.FavorStage] = v
		end
	end

	local preIndex = index - 1
	local preCfg = tab[preIndex]
	local curCfg = tab[index]
	local favorStage, LoveStage = self.girlData:GetGirlStage()

	if index < favorStage then
		if preCfg then
			maxNum = curCfg.FavorValue - preCfg.FavorValue
		else
			maxNum = curCfg.FavorValue
		end

		num = maxNum
	else
		if preCfg then
			maxNum = curCfg.FavorValue - preCfg.FavorValue
			num = self.girlData.favor - preCfg.FavorValue
		else
			maxNum = curCfg.FavorValue
			num = self.girlData.favor
		end

		num = num < 0 and 0 or num
	end

	return num, maxNum
end

function m:OnBtnPhone()
	if not self.girlData.unLockPhone then
		NoticeModule.ShowNotice(21045050)

		return
	end

	local funDataTable = self.girlData:GetGirlFunctionBySubType({
		MonsterAcademyConstant.FunctionSubType.FunctionSubType_Dialog,
		MonsterAcademyConstant.FunctionSubType.FunctionSubType_Notice
	})

	if #funDataTable > 1 then
		warning("妹子电话配置错误，可同时打电话长度大于1")

		for i, v in pairs(funDataTable) do
			warning("FunctionID = " .. v.cfgID)
		end

		return
	end

	if #funDataTable == 0 then
		NoticeModule.ShowNotice(21045055)

		return
	end

	local funData = funDataTable[1]

	if funData.cfgFunction.FunctionSubType == 11 then
		NoticeModule.ShowNotice(funData.cfgFunction.Parameter[1])

		return
	end

	UIModule.Open(Constant.UIControllerName.MonsterAcademyPlayerCallPhoneUI, Constant.UILayer.UI, {
		GirlID = self.girlData.cfgID,
		FunctionCid = funData.cfgID
	})
end

function m:OnBtnMessage()
	if not self.girlData.unLockPhone then
		NoticeModule.ShowNotice(21045050)

		return
	end

	UIModule.Open(Constant.UIControllerName.MonsterAcademyMessageUI, Constant.UILayer.UI, {
		GirlID = self.girlData.cfgID
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.monsterGirlStarPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
