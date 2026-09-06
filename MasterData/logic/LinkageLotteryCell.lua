-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/view/LinkageLotteryCell.lua

module("logic.extensions.linkagelottery.view.LinkageLotteryCell", package.seeall)

local LinkageLotteryCell = class("LinkageLotteryCell")
local BigPrize = 1

function LinkageLotteryCell:ctor(luaComponentContainer)
	local parentGo = luaComponentContainer.gameObject

	self._mainGO = parentGo
	self._anim = goutil.findChild(parentGo, "anim")
	self._animRect = self._anim:GetComponent(goutil.Type_RectTransform)
	self._icon = goutil.findChild(parentGo, "anim/icon")
	self._img = goutil.findChild(parentGo, "anim/img")
	self._geted = goutil.findChild(parentGo, "anim/geted")
	self._select = goutil.findChild(parentGo, "anim/select")
	self._btnTip = Framework.ButtonAdapter.Get(self._icon)

	self._btnTip:AddClickListener(self._onClickTip, self)
end

function LinkageLotteryCell:getMainGo()
	return self._mainGO
end

function LinkageLotteryCell:getAnimGo()
	return self._anim
end

function LinkageLotteryCell:updateCell(data)
	self._data = data

	goutil.setActive(self._geted, data.isGeted)
	goutil.setActive(self._select, false)
	printInfo("test data", data.isBigPrize, BigPrize, data.isBigPrize ~= BigPrize)

	if data.isBigPrize ~= BigPrize then
		goutil.setActive(self._icon, true)
		goutil.setActive(self._img, true)

		local matType, matId = MaterialMgr.getMatParams(data.prize)

		MaterialMgr.setIcon(self._icon, matType, matId)
		self:_startRewardAnim()
	else
		goutil.setActive(self._icon, false)
		goutil.setActive(self._img, false)
		self:_clearTween()
	end
end

function LinkageLotteryCell:isBigPrize()
	return self._data.isBigPrize == BigPrize
end

function LinkageLotteryCell:setSelect(lotteryId)
	local isSelect = self._data.lotteryId == lotteryId

	goutil.setActive(self._select, isSelect)
end

function LinkageLotteryCell:updateGetState(isGeted)
	self._data.isGeted = isGeted

	goutil.setActive(self._geted, isGeted)
end

function LinkageLotteryCell:getLotteryId()
	return self._data.lotteryId
end

function LinkageLotteryCell:reset()
	MaterialMgr.clearIcon(self._icon)
	self:_clearTween()
end

function LinkageLotteryCell:_startRewardAnim()
	local num = self._data.lotteryId
	local delay = num * 0.2

	printInfo("test 延时", delay)

	local startX = 0
	local startY = -10
	local endY = 10
	local infinite = -1

	self:_clearTween()
	Framework.TransformUtil.SetAnchoredPos(self._animRect, startX, startY)

	self._tween = self._animRect:DOAnchorPosY(endY, 3):SetDelay(delay):SetEase(DG.Tweening.Ease.InOutQuad):SetLoops(infinite, DG.Tweening.LoopType.Yoyo)
end

function LinkageLotteryCell:_clearTween()
	if self._tween then
		self._tween:Kill()
	end
end

function LinkageLotteryCell:_onClickTip()
	local matType, id = MaterialMgr.getMatParams(self._data.prize)

	CommonTipsMgr.instance:openMaterialTips(self._icon, matType, id, 0)
end

return LinkageLotteryCell
