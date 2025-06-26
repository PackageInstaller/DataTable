-- chunkname: @IQIGame\\UI\\Dialog\\DialogueAction\\DialogueAction_EnterStory.lua

local DialogueBase = require("IQIGame/UI/Dialog/DialogueAction/DialogueActionBase")
local m = classF(DialogueBase)

function m:ctor(args)
	self.args = args
	self.isComplete = false
end

function m:OnStart()
	if self.isComplete then
		return
	end

	if self.args.chapterPassType == Constant.ChapterPassType.TYPE_MAINLINE then
		StoryChapterModule.EnterDup(self.args.chapterId)
	else
		logError("【对话】没有指定章节类型 = " .. self.args.chapterPassType)
	end

	self.isComplete = true
end

return m
