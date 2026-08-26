-- chunkname: @modules/logic/story/view/actChapter/StoryActivityChapterPlayer.lua

module("modules.logic.story.view.actChapter.StoryActivityChapterPlayer", package.seeall)

local StoryActivityChapterPlayer = class("StoryActivityChapterPlayer", UserDataDispose)

StoryActivityChapterPlayer.StoryType = {
	Close = 2,
	Open = 1
}
StoryActivityChapterPlayer.VersionSetting = {
	{
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen1_1",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose1_1"
	},
	{
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen1_2",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose1_2"
	},
	{
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen1_3",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose1_3"
	},
	[5] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen1_5",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose1_5"
	},
	[6] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen1_6",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose1_6"
	},
	[8] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen1_8",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose1_8"
	},
	[20] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen2_0",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose2_0"
	},
	[21] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen2_1",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose2_1"
	},
	[23] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen2_3",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose2_3"
	},
	[24] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen2_4",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose2_4"
	},
	[25] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen2_5",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose2_5"
	},
	[27] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen2_7",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose2_7"
	},
	[2901] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpenSP01_1",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterCloseSP01_1"
	},
	[2902] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpenSP01_2",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterCloseSP01_2"
	},
	[31] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_1",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_1"
	},
	[32] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_2",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_2"
	},
	[34] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_4",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_4"
	},
	[35] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_5",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_5"
	},
	[36] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_6",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_6"
	},
	[38] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_8",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_8"
	},
	[3100] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpenSP02",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterCloseSP02"
	},
	[39] = {
		[StoryActivityChapterPlayer.StoryType.Open] = "StoryActivityChapterOpen3_9",
		[StoryActivityChapterPlayer.StoryType.Close] = "StoryActivityChapterClose3_9"
	}
}

function StoryActivityChapterPlayer:ctor(go)
	self:__onInit()

	self.viewGO = go
	self.logicItems = {}
end

function StoryActivityChapterPlayer:getLogic(chapter, storyType)
	local logicName = StoryActivityChapterPlayer.VersionSetting[chapter][storyType]

	return self:getLogicByName(logicName)
end

function StoryActivityChapterPlayer:getLogicByName(logicName)
	if not self.logicItems[logicName] then
		local logic = _G[logicName]

		self.logicItems[logicName] = logic.New(self.viewGO)
	end

	return self.logicItems[logicName]
end

function StoryActivityChapterPlayer:playStart(co)
	gohelper.setActive(self.viewGO, true)

	local vals = string.splitToNumber(co.navigateChapterEn, "#")

	if not vals[1] then
		local chapter = 1

		if not vals[2] then
			local logic = self:getLogic(chapter, StoryActivityChapterPlayer.StoryType.Open)

			logic:setData(co)
		end
	end
end

function StoryActivityChapterPlayer:loadStartImg(chapter, part)
	local func = self[string.format("loadStartImg" .. chapter)]

	if func then
		func(self, chapter, part)
	end
end

function StoryActivityChapterPlayer:playEnd(co)
	gohelper.setActive(self.viewGO, true)

	local txt = co.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	if string.nilorempty(txt) then
		txt = co.navigateChapterEn
	end

	local showTxt, chapter

	if tonumber(txt) then
		chapter = tonumber(txt)
	else
		local strs = string.split(txt, "#")

		if strs[1] and strs[2] then
			chapter = strs[1]
			showTxt = strs[2]
		else
			showTxt = strs[1]
		end
	end

	chapter = chapter or 1

	local logic = self:getLogic(tonumber(chapter), StoryActivityChapterPlayer.StoryType.Close)

	logic:setData(showTxt)
end

function StoryActivityChapterPlayer:playRoleStoryStart(co)
	gohelper.setActive(self.viewGO, true)

	local logic = self:getLogicByName("RoleStoryChapterOpen")

	logic:setData(co)
end

function StoryActivityChapterPlayer:hide()
	gohelper.setActive(self.viewGO, false)

	if self.logicItems then
		for k, v in pairs(self.logicItems) do
			v:hide()
		end
	end
end

function StoryActivityChapterPlayer:dispose()
	if self.logicItems then
		for k, v in pairs(self.logicItems) do
			v:onDestory()
		end
	end

	self:__onDispose()
end

return StoryActivityChapterPlayer
