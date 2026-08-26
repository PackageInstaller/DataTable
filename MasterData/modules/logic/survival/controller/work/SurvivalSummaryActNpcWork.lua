-- chunkname: @modules/logic/survival/controller/work/SurvivalSummaryActNpcWork.lua

module("modules.logic.survival.controller.work.SurvivalSummaryActNpcWork", package.seeall)

local SurvivalSummaryActNpcWork = class("SurvivalSummaryActNpcWork", BaseWork)

function SurvivalSummaryActNpcWork:ctor(param)
	self.SurvivalSummaryNpcHUD = param.SurvivalSummaryNpcHUD
	self.bubbleList = {}
end

function SurvivalSummaryActNpcWork:onStart()
	local scene = SurvivalMapHelper.instance:getScene()

	self.npcDataList = scene.actProgress.npcDataList
	self.npcList = scene.actProgress.npcList

	for i, survivalSummaryActNpcEntity in ipairs(self.npcList) do
		local data = self.npcDataList[i]

		self:createBubbleItem(data.id, data.upInfo, survivalSummaryActNpcEntity.go)
	end

	AudioMgr.instance:trigger(AudioEnum3_1.Survival.ui_mingdi_tansuo_bubble_eject)
	self:onDone(true)
end

function SurvivalSummaryActNpcWork:createBubbleItem(npcId, upInfo, followerGO)
	local cloneGO = gohelper.cloneInPlace(self.SurvivalSummaryNpcHUD)

	gohelper.setActive(cloneGO, true)

	local bubble = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, SurvivalSummaryNpcHUD, followerGO)

	bubble:setData(npcId, upInfo)
	table.insert(self.bubbleList, bubble)
end

function SurvivalSummaryActNpcWork:playCloseAnim()
	for i, v in ipairs(self.bubbleList) do
		v:playCloseAnim()
	end
end

function SurvivalSummaryActNpcWork:onDestroy()
	SurvivalSummaryActNpcWork.super.onDestroy(self)
end

return SurvivalSummaryActNpcWork
