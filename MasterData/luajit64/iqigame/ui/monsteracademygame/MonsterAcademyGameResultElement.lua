-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\MonsterAcademyGameResultElement.lua

local m = {}

function m.New(viewRoot, api)
	local obj = Clone(m)

	obj:__Init(viewRoot, api)

	return obj
end

function m:__Init(viewRoot, api)
	self.ViewRoot = viewRoot
	self.langApi = api

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	self.CloseBtnText:GetComponent("UnityEngine.UI.Text").text = self.langApi:GetString("GetCloseButtonText")

	self:ResetShow()
end

function m:ResetShow()
	self.ViewRoot.gameObject:SetActive(false)
	self.goSu.gameObject:SetActive(false)
	self.goFa.gameObject:SetActive(false)

	if self.goScore ~= nil then
		self.goScore.gameObject:SetActive(false)
	end
end

function m:ShowScore(target, score)
	if self.goScoreText2 ~= nil then
		self.goScoreText2.gameObject:GetComponent("Text").text = self.langApi:GetString("GetTargetScoreText", target)
	end

	if self.goScoreText1 ~= nil then
		self.goScoreText1.gameObject:GetComponent("Text").text = self.langApi:GetString("GetScoreText", score)
	end

	if self.goScore ~= nil then
		self.goScore.gameObject:SetActive(true)
	end
end

function m:ShowSuccess()
	GameEntry.Sound:PlaySound(10264, Constant.SoundGroup.UI)
	self.goSu.gameObject:SetActive(true)
	self.ViewRoot.gameObject:SetActive(true)
end

function m:ShowFail()
	GameEntry.Sound:PlaySound(10265, Constant.SoundGroup.UI)
	self.goFa.gameObject:SetActive(true)
	self.ViewRoot.gameObject:SetActive(true)
end

function m:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)

	self.ViewRoot = nil
end

return m
