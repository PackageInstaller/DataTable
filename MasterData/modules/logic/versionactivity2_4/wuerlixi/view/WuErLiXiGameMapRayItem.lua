-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiGameMapRayItem.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapRayItem", package.seeall)

local WuErLiXiGameMapRayItem = class("WuErLiXiGameMapRayItem", LuaCompBase)

function WuErLiXiGameMapRayItem:init(go)
	self._uiRootTrans = ViewMgr.instance:getUIRoot().transform
	self.go = go
	self._imageicon = gohelper.findChildImage(go, "icon")

	gohelper.setActive(self._imageicon.gameObject, false)

	self._imagenormalsignal = gohelper.findChildImage(go, "icon1")
	self._imageswitchsignal = gohelper.findChildImage(go, "icon2")
	self._imagenormalMat = UnityEngine.GameObject.Instantiate(self._imagenormalsignal.material)
	self._imagenormalsignal.material = self._imagenormalMat
	self._imageswitchMat = UnityEngine.GameObject.Instantiate(self._imageswitchsignal.material)
	self._imageswitchsignal.material = self._imageswitchMat
	self._matTempVector = Vector4(0, 0, 0, 0)

	local _shader = UnityEngine.Shader

	self._startKey = _shader.PropertyToID("_StartVec")
	self._endKey = _shader.PropertyToID("_EndVec")
end

function WuErLiXiGameMapRayItem:setItem(mo, startNodeItem, endNodeItem)
	gohelper.setActive(self.go, false)

	self._mo = mo
	self.go.name = string.format("%s_%s#%s_%s", self._mo.startPos[2], self._mo.startPos[1], self._mo.endPos[2], self._mo.endPos[1])
	self._startNodeItem = startNodeItem
	self._endNodeItem = endNodeItem

	transformhelper.setLocalRotation(self.go.transform, 0, 0, -90 * self._mo.rayDir)
	recthelper.setHeight(self._imageicon.gameObject.transform, self._mo:getSignalLength() * WuErLiXiEnum.GameMapNodeWidth)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, string.format("v2a4_wuerlixi_ray_icon%s", self._mo.rayType))
	gohelper.setActive(self._imagenormalsignal.gameObject, self._mo.rayType == WuErLiXiEnum.RayType.NormalSignal)
	gohelper.setActive(self._imageswitchsignal.gameObject, self._mo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
	TaskDispatcher.runDelay(self.setPos, self, 0.05)
end

function WuErLiXiGameMapRayItem:setPos()
	gohelper.setActive(self.go, true)

	local startX, startY, startZ = transformhelper.getPos(self._startNodeItem.go.transform)

	transformhelper.setPos(self.go.transform, startX, startY, 0)

	self._curRayLength = 0
	self._lastEndNodeItem = self._startNodeItem

	self:_setLineStartPos()
	self:_playItemForward()
end

function WuErLiXiGameMapRayItem:_setLinePosition(mat, key, x, y)
	self._matTempVector.x = x
	self._matTempVector.y = y

	mat:SetVector(key, self._matTempVector)
end

function WuErLiXiGameMapRayItem:_setLineStartPos()
	local pos = self._startNodeItem.go.gameObject.transform.position
	local x, y = recthelper.rectToRelativeAnchorPos2(pos, self._uiRootTrans)

	self:_setLinePosition(self._imagenormalMat, self._startKey, x, y)
	self:_setLinePosition(self._imageswitchMat, self._startKey, x, y)
end

function WuErLiXiGameMapRayItem:_setLineEndPos()
	local pos = self._endNodeItem.go.transform.position
	local x, y = recthelper.rectToRelativeAnchorPos2(pos, self._uiRootTrans)

	self:_setLinePosition(self._imagenormalMat, self._endKey, x, y)
	self:_setLinePosition(self._imageswitchMat, self._endKey, x, y)
end

function WuErLiXiGameMapRayItem:resetItem(mo, endNodeItem)
	if not self._curRayLength then
		TaskDispatcher.cancelTask(self.setPos, self, 0.05)

		self._curRayLength = 0
		self._lastEndNodeItem = self._startNodeItem

		self:_setLineStartPos()
	end

	if mo.rayType ~= self._mo.rayType or mo.rayDir ~= self._mo.rayDir then
		self:hide()
	end

	if self._forwardTweenId then
		ZProj.TweenHelper.KillById(self._forwardTweenId)

		self._forwardTweenId = nil
	end

	gohelper.setActive(self.go, true)

	self._lastEndNodeItem = self._endNodeItem
	self._endNodeItem = endNodeItem
	self._mo = mo

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(self._imageicon, string.format("v2a4_wuerlixi_ray_icon%s", self._mo.rayType))

	self.go.name = string.format("%s_%s#%s_%s", self._mo.startPos[2], self._mo.startPos[1], self._mo.endPos[2], self._mo.endPos[1])

	gohelper.setActive(self._imagenormalsignal.gameObject, self._mo.rayType == WuErLiXiEnum.RayType.NormalSignal)
	gohelper.setActive(self._imageswitchsignal.gameObject, self._mo.rayType == WuErLiXiEnum.RayType.SwitchSignal)
	self:_playItemForward()
end

function WuErLiXiGameMapRayItem:_playItemForward()
	local length = self._curRayLength

	self._curRayLength = math.abs(self._mo.startPos[2] + self._mo.startPos[1] - self._mo.endPos[2] - self._mo.endPos[1])

	local speed = CommonConfig.instance:getConstNum(ConstEnum.WuErLiXiOnNodeSec)

	if self._curRayLength - length > 0 then
		if not (0.001 * (self._curRayLength - length) * speed) then
			local time = 0

			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock("forwardPlaying")

			self._forwardTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, time, self._forwardUpdate, self._forwardFinished, self)
		end
	end
end

function WuErLiXiGameMapRayItem:_forwardUpdate(value)
	local lastX, lastY = recthelper.rectToRelativeAnchorPos2(self._lastEndNodeItem.go.transform.position, self._uiRootTrans)
	local curX, curY = recthelper.rectToRelativeAnchorPos2(self._endNodeItem.go.transform.position, self._uiRootTrans)

	self:_setLinePosition(self._imagenormalMat, self._endKey, lastX + value * (curX - lastX), lastY + value * (curY - lastY))
	self:_setLinePosition(self._imageswitchMat, self._endKey, lastX + value * (curX - lastX), lastY + value * (curY - lastY))
end

function WuErLiXiGameMapRayItem:_forwardFinished()
	UIBlockMgr.instance:endBlock("forwardPlaying")
	self:_setLineEndPos()
end

function WuErLiXiGameMapRayItem:hide()
	self._curRayLength = 0
	self._endNodeItem = self._startNodeItem
	self._lastEndNodeItem = self._startNodeItem

	self:_setLineEndPos()
	gohelper.setActive(self.go, false)
end

function WuErLiXiGameMapRayItem:destroy()
	if self._forwardTweenId then
		ZProj.TweenHelper.KillById(self._forwardTweenId)

		self._forwardTweenId = nil
	end

	TaskDispatcher.cancelTask(self.setPos, self)
end

return WuErLiXiGameMapRayItem
