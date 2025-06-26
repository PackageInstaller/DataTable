-- chunkname: @IQIGame\\UI\\Guide\\GuideNpcTalkView.lua

local GuideNpcTalkView = {
	talkIndex = 0,
	talkRenders = {},
	npcTalks = {}
}
local GuideNpcTalkRender = require("IQIGame.UI.Guide.GuideNpcTalkRender")

function GuideNpcTalkView.__New(ui, parent)
	local o = Clone(GuideNpcTalkView)

	o:InitView(ui, parent)

	return o
end

function GuideNpcTalkView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)

	function self.delegateStart(data)
		self:OnStart(data)
	end

	function self.delegateEnd(data)
		self:OnEnd(data)
	end

	LuaCodeInterface.BindOutlet(self.rootUI, self)
end

function GuideNpcTalkView:AddEventListener()
	return
end

function GuideNpcTalkView:RemoveEventListener()
	return
end

function GuideNpcTalkView:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuideNpcTalkView:OnUpdate(elapseSeconds, realElapseSeconds)
	for i, v in pairs(self.talkRenders) do
		v:OnUpdate(elapseSeconds, realElapseSeconds)
	end
end

function GuideNpcTalkView:UpDateView()
	self.rootUI:SetActive(true)

	self.rootUI:GetComponent("SortedComponentOrder").Order = self.guideModuleData[2]

	local col = self:HexToColor(self.guideModuleData[11])

	self.ImgBG:GetComponent("Image").color = col

	local top = self.guideModuleData[12] == 1 and true or false

	self.ImgBG:SetActive(top)

	local isShowLevel2d = self.guideModuleData[13] == 1 and true or false

	EventDispatcher.Dispatch(EventID.GuideIsShowLevel2D, isShowLevel2d)
end

function GuideNpcTalkView:HexToColor(hex)
	local str = string.sub(hex, 2, 17)
	local s = string.sub(str, 1, 2)
	local r = tonumber(s, 16) / 255

	s = string.sub(str, 3, 4)

	local g = tonumber(s, 16) / 255

	s = string.sub(str, 5, 6)

	local b = tonumber(s, 16) / 255

	s = string.sub(str, 7, 8)

	local a = tonumber(s, 16) / 255

	return Color.New(r, g, b, a)
end

function GuideNpcTalkView:UpDatePose()
	return
end

function GuideNpcTalkView:OnStart(data)
	self.guideModuleData = data.guideModuleData

	self:UpDateView()
end

function GuideNpcTalkView:OnEnd(data)
	self.talkIndex = data.index

	if self.talkIndex >= #self.npcTalks then
		if self.talkEndBack then
			self.talkEndBack(self.guideSubID)
		end

		self.talkEndBack = nil

		self:Close()
	else
		local nextTalkRender = self.talkRenders[self.talkIndex + 1]

		nextTalkRender:OpenImmediately()
	end
end

function GuideNpcTalkView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuideNpcTalkView:Open(data, guideSubID)
	self.npcTalks = data
	self.guideSubID = guideSubID
	self.talkRenders = {}
	self.talkIndex = 0

	for i = 1, #self.npcTalks do
		local data = self.npcTalks[i]
		local typePos = data[14]
		local objTalk = UnityEngine.GameObject.Instantiate(self["TalkMould" .. typePos])

		objTalk.transform:SetParent(self.TalkNode.transform, false)

		local talkRender = GuideNpcTalkRender.__New(objTalk, i)

		talkRender.startCallBack = self.delegateStart
		talkRender.endCallBack = self.delegateEnd

		table.insert(self.talkRenders, talkRender)

		if i == 1 then
			talkRender:Open(data, true)
		else
			talkRender:Open(data, false)
		end
	end

	self:AddEventListener()
end

function GuideNpcTalkView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)
	EventDispatcher.Dispatch(EventID.GuideIsShowLevel2D, true)
	UnityEngine.GameObject.DestroyImmediate(self.npcObj)
end

return GuideNpcTalkView
