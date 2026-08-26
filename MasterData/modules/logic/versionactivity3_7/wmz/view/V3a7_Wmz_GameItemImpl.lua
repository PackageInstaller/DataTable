-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_GameItemImpl.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_GameItemImpl", package.seeall)

local V3a7_Wmz_GameItemImpl = class("V3a7_Wmz_GameItemImpl", V3a7_Wmz_GameItemBase)

function V3a7_Wmz_GameItemImpl:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._goPiece = gohelper.findChild(self.viewGO, "#go_Piece")
	self._goLine0 = gohelper.findChild(self.viewGO, "#go_Line_0")
	self._goLine1 = gohelper.findChild(self.viewGO, "#go_Line_1")
	self._goLineStart = gohelper.findChild(self.viewGO, "#go_Line_Start")
	self._goBorder = gohelper.findChild(self.viewGO, "#go_Border")
	self._goFrame = gohelper.findChild(self.viewGO, "#go_Frame")
	self._godragArea = gohelper.findChild(self.viewGO, "#go_dragArea")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_Wmz_GameItemImpl:addEvents()
	return
end

function V3a7_Wmz_GameItemImpl:removeEvents()
	return
end

function V3a7_Wmz_GameItemImpl:ctor(...)
	V3a7_Wmz_GameItemImpl.super.ctor(self, ...)
end

function V3a7_Wmz_GameItemImpl:_editableInitView()
	V3a7_Wmz_GameItemImpl.super._editableInitView(self)

	self._Image_BGGo = gohelper.findChild(self.viewGO, "Image_BG")
	self._line0 = self:_create_V3a7_Wmz_GameItemImpl_Line(self._goLine0)
	self._line1 = self:_create_V3a7_Wmz_GameItemImpl_Line(self._goLine1)
	self._border = self:_create_V3a7_Wmz_GameItem_Border(self._goBorder)
	self._goLineStartTran = self._goLineStart.transform
	self._imgPiece = gohelper.findChildImage(self._goPiece, "")
	self._Image_BG = gohelper.findChildImage(self._Image_BGGo, "")
	self._imgLocked = gohelper.findChildImage(self._goLocked, "")
	self._pieceAnimCmp = self._goPiece:GetComponent(gohelper.Type_Animator)

	self:setActive_goLocked(false)
	self:setActive_goLine(false)
	self:setActive_godragArea(false)
end

function V3a7_Wmz_GameItemImpl:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_line0")
	GameUtil.onDestroyViewMember(self, "_line1")
	V3a7_Wmz_GameItemImpl.super.onDestroyView(self)
end

function V3a7_Wmz_GameItemImpl:isVoid()
	return self._mo:isVoid()
end

function V3a7_Wmz_GameItemImpl:isNothing()
	return self._mo:isNothing()
end

function V3a7_Wmz_GameItemImpl:isWall()
	return self._mo:isWall()
end

function V3a7_Wmz_GameItemImpl:isPassable()
	return self._mo:isPassable()
end

function V3a7_Wmz_GameItemImpl:isPassableEmpty()
	return self._mo:isPassableEmpty()
end

function V3a7_Wmz_GameItemImpl:isEmpty()
	return self._mo:isEmpty()
end

function V3a7_Wmz_GameItemImpl:isPathNone()
	return self._mo:isPathNone()
end

function V3a7_Wmz_GameItemImpl:isStart()
	return self._mo:isStart()
end

function V3a7_Wmz_GameItemImpl:isTile()
	return self._mo:isTile()
end

function V3a7_Wmz_GameItemImpl:id()
	return self._mo:id()
end

function V3a7_Wmz_GameItemImpl:x()
	return self._mo:x()
end

function V3a7_Wmz_GameItemImpl:y()
	return self._mo:y()
end

function V3a7_Wmz_GameItemImpl:xy()
	return self._mo:xy()
end

function V3a7_Wmz_GameItemImpl:pathType()
	return self._mo:pathType()
end

function V3a7_Wmz_GameItemImpl:floorType()
	return self._mo:floorType()
end

function V3a7_Wmz_GameItemImpl:sprite()
	return self._mo:sprite()
end

function V3a7_Wmz_GameItemImpl:finalSprite()
	return self._mo:finalSprite()
end

function V3a7_Wmz_GameItemImpl:indexStr()
	return self._mo:indexStr()
end

function V3a7_Wmz_GameItemImpl:groupId()
	return self._mo:groupId()
end

function V3a7_Wmz_GameItemImpl:bHasGroup()
	return self._mo:bHasGroup()
end

function V3a7_Wmz_GameItemImpl:zoneId()
	return self._mo:zoneId()
end

function V3a7_Wmz_GameItemImpl:zoneIndex()
	return self:getZoneId2Index(self:zoneId())
end

function V3a7_Wmz_GameItemImpl:bInZone()
	return self._mo:bInZone()
end

function V3a7_Wmz_GameItemImpl:bWelded()
	return self._mo:bWelded()
end

function V3a7_Wmz_GameItemImpl:tileId()
	return self._mo:tileId()
end

function V3a7_Wmz_GameItemImpl:getTile()
	return self._mo:getTile()
end

function V3a7_Wmz_GameItemImpl:isIndex(...)
	return self._mo:isIndex(...)
end

function V3a7_Wmz_GameItemImpl:T(...)
	return self._mo:T(...)
end

function V3a7_Wmz_GameItemImpl:R(...)
	return self._mo:R(...)
end

function V3a7_Wmz_GameItemImpl:B(...)
	return self._mo:B(...)
end

function V3a7_Wmz_GameItemImpl:L(...)
	return self._mo:L(...)
end

function V3a7_Wmz_GameItemImpl:setSelected(...)
	self._mo:setSelected(...)
end

function V3a7_Wmz_GameItemImpl:setTileId(...)
	self._mo:setTileId(...)
end

function V3a7_Wmz_GameItemImpl:bZoneCompleted()
	local zoneClearCur = self:zoneClearCurAndMax()

	return zoneClearCur >= self:zoneIndex()
end

function V3a7_Wmz_GameItemImpl:bPlayingZone()
	local curPlayingZoneIndex = self:curPlayingZoneIndex()

	return self:zoneIndex() == curPlayingZoneIndex
end

function V3a7_Wmz_GameItemImpl:setData(mo)
	V3a7_Wmz_GameItemImpl.super.setData(self, mo)

	local isCompleted = self:isCompleted() or self:bZoneCompleted()
	local bShowLocked = self:isWall() and not isCompleted

	self:setActive_goLocked(bShowLocked)
	self:setActive_Image_BGGo(not self:isVoid())

	if self:isPathNone() then
		self._line0:setActive(false)
		self._line1:setActive(false)
	end

	local sprite = isCompleted and self:finalSprite() or self:sprite()

	if not string.nilorempty(sprite) then
		local bShowSprite = isCompleted or not self:isPassableEmpty()

		self:setSprite(self._imgPiece, sprite)
		self:setActive_goPiece(bShowSprite)
		self:setActive_Image_BGGo(not bShowSprite)
	else
		self:setActive_goPiece(false)
	end

	self:_refreshBorder()
	self:playAnim_PieceIdle(isCompleted)
	self:setGrayScale(self:bSelectedZone())
end

function V3a7_Wmz_GameItemImpl:resetPos()
	local gridObj = self._mo
	local ax, ay = self:coordToAPosInContentSpace(gridObj:xy())

	self:setAPos(ax, ay)
	self:_debug_refresh()
end

function V3a7_Wmz_GameItemImpl:setActive_goLocked(bActive)
	gohelper.setActive(self._goLocked, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_goLineStart(bActive)
	gohelper.setActive(self._goLineStart, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_godragArea(bActive)
	gohelper.setActive(self._godragArea, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_goLine(bWelded)
	self._line0:setActive(not bWelded)
	self._line1:setActive(bWelded)

	if not self._mo or self:isPathNone() then
		-- block empty
	else
		if self._tmpbWelded == nil then
			-- block empty
		elseif self._tmpbWelded ~= bWelded and bWelded then
			AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_02)
		end

		self._tmpbWelded = bWelded
	end
end

function V3a7_Wmz_GameItemImpl:setActive_goPiece(bActive)
	gohelper.setActive(self._goPiece, bActive)
end

function V3a7_Wmz_GameItemImpl:setActive_Image_BGGo(bActive)
	gohelper.setActive(self._Image_BGGo, bActive)
end

function V3a7_Wmz_GameItemImpl:playIdleAnim()
	return
end

function V3a7_Wmz_GameItemImpl:playAnim_PieceIdle(bWelded)
	if true then
		self:_playAnim_PieceLighted()
	else
		self:_playAnim_PieceGray()
	end
end

function V3a7_Wmz_GameItemImpl:playAnim_PieceLight()
	self._pieceAnimCmp.enabled = true

	self._pieceAnimCmp:Play("light", 0, 0)
end

function V3a7_Wmz_GameItemImpl:_playAnim_PieceGray()
	self._pieceAnimCmp.enabled = true

	self._pieceAnimCmp:Play("gray", 0, 1)
end

function V3a7_Wmz_GameItemImpl:_playAnim_PieceLighted()
	self._pieceAnimCmp.enabled = true

	self._pieceAnimCmp:Play("lighted", 0, 1)
end

function V3a7_Wmz_GameItemImpl:_create_V3a7_Wmz_GameItemImpl_Line(srcGo)
	local item = self:newObject(V3a7_Wmz_GameItemImpl_Line)

	item:init(srcGo)

	return item
end

function V3a7_Wmz_GameItemImpl:_create_V3a7_Wmz_GameItem_Border(srcGo)
	local item = self:newObject(V3a7_Wmz_GameItem_Border)

	item:init(srcGo)

	return item
end

function V3a7_Wmz_GameItemImpl:_setAsCellBorder()
	local bDisactive = self:isVoid()

	if bDisactive then
		self._border:setActive(false)

		return
	end

	self._border:setActive(true)

	local TCell = self:T()
	local RCell = self:R()
	local BCell = self:B()
	local LCell = self:L()

	local function _handler(eDir, cellObj)
		if not cellObj or cellObj:isVoid() then
			self._border:setActive_Edge(eDir, true)
		else
			self._border:setActive_Edge(eDir, false)
		end
	end

	_handler(WmzEnum.Dir.Up, TCell)
	_handler(WmzEnum.Dir.Right, RCell)
	_handler(WmzEnum.Dir.Down, BCell)
	_handler(WmzEnum.Dir.Left, LCell)
end

function V3a7_Wmz_GameItemImpl:_setAsTileBorder()
	self._border:setActive(true)

	local gp = self:groupId()

	if gp == 0 then
		self._border:setActiveAllEdges(true)

		return
	end

	local TCell = self:T()
	local RCell = self:R()
	local BCell = self:B()
	local LCell = self:L()

	local function _handler(eDir, cellObj)
		if not cellObj then
			self._border:setActive_Edge(eDir, true)
		else
			self._border:setActive_Edge(eDir, cellObj:groupId() ~= gp)
		end
	end

	_handler(WmzEnum.Dir.Up, TCell)
	_handler(WmzEnum.Dir.Right, RCell)
	_handler(WmzEnum.Dir.Down, BCell)
	_handler(WmzEnum.Dir.Left, LCell)
end

function V3a7_Wmz_GameItemImpl:_refreshBorder()
	assert(false, "please override this function")
end

function V3a7_Wmz_GameItemImpl:onCompleteZone(bCompleted)
	self:setActive_godragArea(not bCompleted)

	if bCompleted then
		self:setActive_goLocked(not bCompleted)

		local sprite = self:finalSprite()

		if not string.nilorempty(sprite) then
			self:setSprite(self._imgPiece, sprite)
			self:setActive_goPiece(true)
		else
			self:setActive_goPiece(false)
		end

		self:playAnim_PieceLight()
	else
		self:playAnim_PieceIdle(false)
		self:refresh()
		self:resetPos()
	end
end

local kWhite = Color.white

function V3a7_Wmz_GameItemImpl:setGrayScale(bSelected)
	self:_playAnim_PieceLighted()

	if bSelected then
		self._imgPiece.color = kWhite
		self._Image_BG.color = kWhite
		self._imgLocked.color = kWhite
	else
		self._pieceAnimCmp:Update(0)

		self._pieceAnimCmp.enabled = false

		local hexColor = WmzConfig.instance:grayScaleHex()

		UIColorHelper.set(self._imgPiece, hexColor)
		UIColorHelper.set(self._Image_BG, hexColor)
		UIColorHelper.set(self._imgLocked, hexColor)
	end

	self._border:setGrayScale(bSelected)

	if not self:isVoid() then
		self._line0:setGrayScale(bSelected)
	end
end

return V3a7_Wmz_GameItemImpl
