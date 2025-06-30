-- chunkname: @IQIGame\\UI\\GlobalNotice\\GlobalBuffNoticeElement.lua

local GlobalBuffNoticeElement = {
	isFree = true
}

function GlobalBuffNoticeElement.New(view)
	local obj = Clone(GlobalBuffNoticeElement)

	obj:__Init(view)

	return obj
end

function GlobalBuffNoticeElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.animaCom = self.gameObject:GetComponent("Animation")

	UIEventUtil.AddClickEventListener_Button(self, "SkinBtn", self.__OnSkipBtnClickHandler)
end

function GlobalBuffNoticeElement:Show(buffCid, completeCall)
	self.__step = 0
	self.isFree = false
	self.__showCompleteCall = completeCall

	self.gameObject:SetActive(true)

	local cfgData = CfgGlobalBuffTable[buffCid]

	self.BuffName:GetComponent("Text").text = cfgData.Name
	self.DescText:GetComponent("Text").text = cfgData.Describe

	self.animaCom:Play("GlobalBuffNotice_Show")

	self.__step = 1
end

function GlobalBuffNoticeElement:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.__step == 1 then
		if self.animaCom:IsPlaying("GlobalBuffNotice_Show") then
			return
		end

		self:__OnShowAnimComplete()
	end

	if self.__step == 2 then
		if self.animaCom:IsPlaying("GlobalBuffNotice_Hide") then
			return
		end

		self:__OnNoticeShowComplete()
	end
end

function GlobalBuffNoticeElement:Hide()
	self.animaCom:Stop()

	self.isFree = true

	self.gameObject:SetActive(false)
end

function GlobalBuffNoticeElement:Dispose()
	self.animaCom:Stop()

	self.animaCom = nil

	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function GlobalBuffNoticeElement:__OnSkipBtnClickHandler()
	if self.__step ~= 1 then
		return
	end

	self.__step = 0

	self:__OnShowAnimComplete()
end

function GlobalBuffNoticeElement:__OnShowAnimComplete()
	self.animaCom:Play("GlobalBuffNotice_Hide")

	self.__step = 2
end

function GlobalBuffNoticeElement:__OnNoticeShowComplete()
	self:Hide()

	if self.__showCompleteCall == nil then
		return
	end

	self.__showCompleteCall()
end

return GlobalBuffNoticeElement
