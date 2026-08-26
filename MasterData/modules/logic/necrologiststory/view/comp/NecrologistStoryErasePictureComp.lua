-- chunkname: @modules/logic/necrologiststory/view/comp/NecrologistStoryErasePictureComp.lua

module("modules.logic.necrologiststory.view.comp.NecrologistStoryErasePictureComp", package.seeall)

local NecrologistStoryErasePictureComp = class("NecrologistStoryErasePictureComp", LuaCompBase)

function NecrologistStoryErasePictureComp:init(go)
	self.go = go
	self.transform = go.transform
	self.imgNormal = gohelper.findChildImage(go, "normal")
	self.imgMask = gohelper.findChildImage(go, "mask")
	self.simageNormal = gohelper.findChildSingleImage(go, "normal")
	self.simageMask = gohelper.findChildSingleImage(go, "mask")
end

function NecrologistStoryErasePictureComp:setMaterial(lockMaterial)
	if gohelper.isNil(self.imgMask) then
		return
	end

	self.imgMask.material = lockMaterial
end

function NecrologistStoryErasePictureComp:setEraseData(picPath, brushSize, finishRate)
	self._isFinish = false
	self.brushSize = brushSize
	self.finishRate = finishRate

	gohelper.setActive(self.imgMask, true)
	self.simageNormal:LoadImage(picPath, self.onNormalLoaded, self)
	self.simageMask:LoadImage(picPath, self.onMaskLoaded, self)
end

function NecrologistStoryErasePictureComp:onNormalLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageNormal.gameObject)
end

function NecrologistStoryErasePictureComp:onMaskLoaded()
	ZProj.UGUIHelper.SetImageSize(self.simageMask.gameObject)
	self:addComp()
end

function NecrologistStoryErasePictureComp:addComp()
	self.erasePicture = ZProj.ErasePicture.AddComp(self.imgMask.gameObject)

	self.erasePicture:setCallBack(self.startDraw, self, self.showRate, self, self.endDraw, self, self.finishDraw, self)
	self.erasePicture:InitData(self.brushSize, self.finishRate, self.imgMask, CameraMgr.instance:getUICamera())
end

function NecrologistStoryErasePictureComp:setCallback(startCallback, drawCallback, endCallback, finishCallback, callbackObj)
	self.startCallback = startCallback
	self.drawCallback = drawCallback
	self.endCallback = endCallback
	self.finishCallback = finishCallback
	self.callbackObj = callbackObj
end

function NecrologistStoryErasePictureComp:startDraw()
	if self:isFinish() then
		return
	end

	if self.startCallback then
		self.startCallback(self.callbackObj)
	end
end

function NecrologistStoryErasePictureComp:showRate(rate)
	if self:isFinish() then
		return
	end

	if self.drawCallback then
		self.drawCallback(self.callbackObj, rate)
	end
end

function NecrologistStoryErasePictureComp:endDraw()
	if self:isFinish() then
		return
	end

	if self.endCallback then
		self.endCallback(self.callbackObj)
	end
end

function NecrologistStoryErasePictureComp:finishDraw()
	if self:isFinish() then
		return
	end

	gohelper.setActive(self.imgMask, false)

	self._isFinish = true

	if self.finishCallback then
		self.finishCallback(self.callbackObj)
	end
end

function NecrologistStoryErasePictureComp:isFinish()
	return self._isFinish
end

function NecrologistStoryErasePictureComp:onDestroy()
	return
end

return NecrologistStoryErasePictureComp
