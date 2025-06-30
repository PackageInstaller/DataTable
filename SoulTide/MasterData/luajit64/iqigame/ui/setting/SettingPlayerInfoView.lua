-- chunkname: @IQIGame\\UI\\Setting\\SettingPlayerInfoView.lua

local SettingPlayerInfoView = {
	exhibitionPosTab = {}
}
local SettingExhibitionPosCell = require("IQIGame.UI.Setting.SettingExhibitionPosCell")

function SettingPlayerInfoView.__New(ui)
	local o = Clone(SettingPlayerInfoView)

	o:InitView(ui)

	return o
end

function SettingPlayerInfoView:InitView(ui)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	function self.delegateSettingChangeEvent()
		self:OnSettingChangeEvent()
	end

	self.exhibitionPosTab = {}

	for i = 1, 3 do
		local cell = SettingExhibitionPosCell.New(self["ExhibitionPos" .. i], i)

		self.exhibitionPosTab[i] = cell
	end
end

function SettingPlayerInfoView:OnMainUIOpen()
	return
end

function SettingPlayerInfoView:OnMainUIClose()
	self:Close()
end

function SettingPlayerInfoView:AddEventListener()
	EventDispatcher.AddEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
end

function SettingPlayerInfoView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.PlayerSettingChangeEvent, self.delegateSettingChangeEvent)
end

function SettingPlayerInfoView:UpDateView()
	UGUIUtil.SetText(self.TextName1, SettingUIApi:GetString("TextName1"))
	UGUIUtil.SetText(self.TextValue1, #SoulModule.GetSortedUnlockSoulDataList())
	UGUIUtil.SetText(self.TextName2, SettingUIApi:GetString("TextName2"))
	UGUIUtil.SetText(self.TextValue2, self:GetMaxMazeChapter())
	UGUIUtil.SetText(self.TextBtnSave, SettingUIApi:GetString("TextBtnSave"))
	UGUIUtil.SetText(self.InfoCarTitle, SettingUIApi:GetString("InfoCarTitle"))
	UGUIUtil.SetText(self.InfoMsgTitle, SettingUIApi:GetString("InfoMsgTitle"))
	UGUIUtil.SetText(self.InfoExhibitionTitle, SettingUIApi:GetString("InfoExhibitionTitle"))
	self:UpDateExhibitionPos()
end

function SettingPlayerInfoView:OnSettingChangeEvent()
	self:UpDateExhibitionPos()
end

function SettingPlayerInfoView:UpDateExhibitionPos()
	for i, v in pairs(self.exhibitionPosTab) do
		local data

		if PlayerModule.PlayerInfo.showCollectItems then
			data = PlayerModule.PlayerInfo.showCollectItems[i]
		end

		v:SetData(data)
	end
end

function SettingPlayerInfoView:GetMaxMazeChapter()
	local str = ""
	local num = 0
	local cfgMazeInstance, chapterOrder

	for i = 1, #PlayerModule.PlayerInfo.quickChallenge do
		local id = PlayerModule.PlayerInfo.quickChallenge[i]
		local cfg = CfgMazeInstanceTable[id]

		if CfgChapterTable[cfg.ChapterId].Type == 2 then
			local Order1 = CfgChapterTable[cfg.ChapterId].Order
			local Order2 = cfg.Order
			local rankValue = Order1 * 1000 + Order2

			if num < rankValue then
				num = rankValue
				cfgMazeInstance = cfg
				chapterOrder = Order1
			end
		end
	end

	if cfgMazeInstance then
		str = SettingUIApi:GetString("ChapterValue", chapterOrder, cfgMazeInstance.Order)
	end

	return str
end

function SettingPlayerInfoView:Dispose()
	for i, v in pairs(self.exhibitionPosTab) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function SettingPlayerInfoView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
	self:UpDateView()
end

function SettingPlayerInfoView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return SettingPlayerInfoView
