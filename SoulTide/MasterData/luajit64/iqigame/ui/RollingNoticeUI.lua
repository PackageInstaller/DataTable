-- chunkname: @IQIGame\\UI\\RollingNoticeUI.lua

local RollingNoticeUI = Base:Extend("RollingNoticeUI", "IQIGame.Onigao.UI.RollingNoticeUI", {
	TextPool = {
		Texts = {}
	},
	RollingTexts = {}
})

function RollingNoticeUI.TextPool:Release(textGo)
	textGo:SetActive(false)
	table.insert(self.Texts, textGo)
end

function RollingNoticeUI.TextPool:Obtain()
	local textGo = table.remove(self.Texts, 1)

	textGo:SetActive(true)

	return textGo
end

function RollingNoticeUI:OnInit()
	for i = 1, 2 do
		self.TextPool:Release(self["Text" .. i])
	end
end

function RollingNoticeUI:GetPreloadAssetPaths()
	return nil
end

function RollingNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RollingNoticeUI:OnOpen(userData)
	return
end

function RollingNoticeUI:OnClose(userData)
	return
end

function RollingNoticeUI:OnAddListeners()
	return
end

function RollingNoticeUI:OnRemoveListeners()
	return
end

function RollingNoticeUI:OnPause()
	return
end

function RollingNoticeUI:OnResume()
	return
end

function RollingNoticeUI:OnCover()
	return
end

function RollingNoticeUI:OnReveal()
	return
end

function RollingNoticeUI:OnRefocus(userData)
	return
end

function RollingNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if #self.RollingTexts < 2 then
		self:AddRollingText(NoticeModule.GetRollingNotice())
	end

	local textGo, vec3
	local deleteList = {}

	for i = 1, #self.RollingTexts do
		textGo = self.RollingTexts[i]
		vec3 = textGo.transform.anchoredPosition3D
		vec3.x = vec3.x - 3
		textGo.transform.anchoredPosition3D = vec3

		if vec3.x <= -textGo.transform.sizeDelta.x then
			table.insert(deleteList, i)
		end
	end

	for i = 1, #deleteList do
		textGo = table.remove(self.RollingTexts, deleteList[i])

		self.TextPool:Release(textGo)
	end

	if #self.RollingTexts == 0 then
		UIModule.Close(Constant.UIControllerName.RollingNoticeUI)
	end
end

function RollingNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RollingNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RollingNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RollingNoticeUI:OnDestroy()
	return
end

function RollingNoticeUI:AddRollingText(noticeCid, args)
	if noticeCid == nil or noticeCid == 0 then
		return
	end

	local cfgNoticeData = CfgNoticeTable[noticeCid]
	local content = string.format(cfgNoticeData.Describe, unpack(args))
	local textGo = self.TextPool:Obtain()

	textGo:GetComponent("Text").text = RollingNoticeUIApi:GetString("textGo", content)

	local vec3 = textGo.transform.anchoredPosition3D

	if #self.RollingTexts == 0 then
		vec3.x = self.Mask.transform.sizeDelta.x
	else
		local transOfAheadText = self.RollingTexts[1].transform

		vec3.x = transOfAheadText.anchoredPosition3D.x + transOfAheadText.sizeDelta.x + 150

		if vec3.x < self.Mask.transform.sizeDelta.x then
			vec3.x = self.Mask.transform.sizeDelta.x
		end
	end

	textGo.transform.anchoredPosition3D = vec3

	table.insert(self.RollingTexts, textGo)
end

return RollingNoticeUI
