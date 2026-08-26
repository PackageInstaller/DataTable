-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVotePlayToastWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVotePlayToastWork", package.seeall)

local SurvivalDecreeVotePlayToastWork = class("SurvivalDecreeVotePlayToastWork", BaseWork)

function SurvivalDecreeVotePlayToastWork:ctor(param)
	self.canJump = true

	self:initParam(param)
end

function SurvivalDecreeVotePlayToastWork:initParam(param)
	self.toastList = {}
	self.goVoteState = param.goVoteState
	self.toastDataList = param.toastDataList
	self.goTipsItem = param.goTipsItem
end

function SurvivalDecreeVotePlayToastWork:onStart()
	gohelper.setActive(self.goVoteState, true)

	for i, v in ipairs(self.toastList) do
		gohelper.setActive(v.go, false)
	end

	self.toastCount = #self.toastDataList
	self.curToastIndex = 0

	if self.toastCount > 0 then
		TaskDispatcher.runRepeat(self.playNextToast, self, 0.3, self.toastCount)
	else
		self:onPlayFinish()
	end
end

function SurvivalDecreeVotePlayToastWork:playNextToast()
	self.curToastIndex = self.curToastIndex + 1

	if self.curToastIndex > self.toastCount then
		return
	end

	local item = self:getToastItem(self.curToastIndex)
	local data = self.toastDataList[self.curToastIndex]
	local npcName = data.config.name

	item.txt.text = data.isAgree and formatLuaLang("survival_decreevote_tips_agree", npcName) or formatLuaLang("survival_decreevote_tips_disagree", npcName)

	gohelper.setActive(item.go, true)

	if self.curToastIndex == self.toastCount then
		self:onPlayFinish()
	end
end

function SurvivalDecreeVotePlayToastWork:getToastItem(index)
	local item = self.toastList[index]

	if not item then
		item = {
			go = gohelper.cloneInPlace(self.goTipsItem)
		}
		item.txt = gohelper.findChildTextMesh(item.go, "#txt_Tips")
		self.toastList[index] = item
	end

	return item
end

function SurvivalDecreeVotePlayToastWork:onPlayFinish()
	self:onDone(true)
end

function SurvivalDecreeVotePlayToastWork:clearWork()
	gohelper.setActive(self.goVoteState, false)
	TaskDispatcher.cancelTask(self.playNextToast, self)
end

return SurvivalDecreeVotePlayToastWork
