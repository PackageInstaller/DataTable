-- chunkname: @modules/logic/necrologiststory/view/item/NecrologistStoryErasePictureItem.lua

module("modules.logic.necrologiststory.view.item.NecrologistStoryErasePictureItem", package.seeall)

local NecrologistStoryErasePictureItem = class("NecrologistStoryErasePictureItem", NecrologistStoryControlItem)

function NecrologistStoryErasePictureItem:onInit()
	self.anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.goTips = gohelper.findChild(self.viewGO, "root/tips")
	self.goErase = gohelper.findChild(self.viewGO, "root/go_erase")
	self.eraseComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goErase, NecrologistStoryErasePictureComp)

	local otherResPaths = NecrologistStoryErasePictureItem.getOtherResPath()
	local lockMaterialPath = otherResPaths[1]
	local lockMaterial = self:getRes(lockMaterialPath)

	self.eraseComp:setMaterial(lockMaterial)
	self.eraseComp:setCallback(self.startDraw, self.showRate, self.endDraw, self.finishDraw, self)
end

function NecrologistStoryErasePictureItem:onPlayStory()
	self.inPlayFinishing = false

	local param = string.split(self._controlParam, "#")
	local brushSize = tonumber(param[1])
	local finishRate = tonumber(param[2])
	local picPath = ResUrl.getNecrologistStoryPicBg(param[3])

	self.eraseComp:setEraseData(picPath, brushSize, finishRate)
	gohelper.setActive(self.goTips, true)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.StartErasePic)
end

function NecrologistStoryErasePictureItem:startDraw()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_feichi_spray_loop)
	gohelper.setActive(self.goTips, false)
end

function NecrologistStoryErasePictureItem:showRate(rate)
	return
end

function NecrologistStoryErasePictureItem:endDraw()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_feichi_spray_loop)
end

function NecrologistStoryErasePictureItem:finishDraw()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_feichi_spray_loop)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_qiutu_list_maintain)
	self.anim:Play("finish", 0, 0)

	self.inPlayFinishing = true

	TaskDispatcher.cancelTask(self._delayFinish, self)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.8)
end

function NecrologistStoryErasePictureItem:_delayFinish()
	self.inPlayFinishing = false

	self:onPlayFinish()
end

function NecrologistStoryErasePictureItem:caleHeight()
	return 400
end

function NecrologistStoryErasePictureItem:isDone()
	if self.inPlayFinishing then
		return false
	end

	return self.eraseComp:isFinish()
end

function NecrologistStoryErasePictureItem:onDestroy()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.stop_ui_feichi_spray_loop)
	TaskDispatcher.cancelTask(self._delayFinish, self)
end

function NecrologistStoryErasePictureItem.getResPath()
	return "ui/viewres/dungeon/rolestory/item/necrologiststoryerasepictureitem.prefab"
end

function NecrologistStoryErasePictureItem.getOtherResPath()
	return {
		"ui/materials/dynamic/ui_halfgray2.mat"
	}
end

return NecrologistStoryErasePictureItem
