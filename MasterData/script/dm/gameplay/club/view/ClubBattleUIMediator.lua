-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBattleUIMediator.lua

ClubBattleUIMediator = class("ClubBattleUIMediator", BattleUIMediator, _M)

function ClubBattleUIMediator:initialize()
	super.initialize(self)
end

function ClubBattleUIMediator:dispose()
	super.dispose(self)
end

function ClubBattleUIMediator:onRegister()
	super.onRegister(self)
end

function ClubBattleUIMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
	dump({}, "ClubBattleUIMediator:adjustLayout")
end

function ClubBattleUIMediator:setupViewConfig(viewConfig, isReplay)
	super.setupViewConfig(self, viewConfig, isReplay)
	print("ClubBattleUIMediator:setupViewConfig")
	self._timerWidget:getView():setScale(0.5):offset(0, -20)
	self:stepRightHead()
	self:stepLeftHead()
end

function ClubBattleUIMediator:willStartEnterTransition()
	print("ClubBattleUIMediator:willStartEnterTransition")

	local offset1, offset2, offset3 = cc.p(0, 124), cc.p(0, -143), cc.p(0, 19)

	if self._timerWidget then
		local view = self._timerWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._leftHeadWidget then
		local view = self._leftHeadWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._rightHeadWidget then
		local view = self._rightHeadWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	local offset1, offset2, offset3 = cc.p(100, 0), cc.p(-123, 0), cc.p(23, 0)

	if self._ctrlButtons then
		local view = self._ctrlButtons:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	local offset1, offset2, offset3 = cc.p(-267, 0), cc.p(295, 0), cc.p(-28, 0)

	if self._masterWidget then
		local view = self._masterWidget:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	local offset1, offset2, offset3 = cc.p(0, -226), cc.p(0, 262), cc.p(0, -36)

	if self._cardArray then
		local view = self._cardArray:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end

	if self._energyBar then
		local view = self._energyBar:getView()

		view:offset(offset1.x, offset1.y)
		view:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, offset2), cc.MoveBy:create(0.1, offset3)))
	end
end

function ClubBattleUIMediator:stepRightHead()
	local header = self:getView():getChildByName("header")
	local rightHead = header:getChildByName("rightHead")

	rightHead:removeAllChildren()

	local viewNode = cc.CSLoader:createNode("asset/ui/BattleHeadRLargeWidget.csb")

	rightHead:addChild(viewNode)

	self._rightHeadWidget = self:autoManageObject(BattleHeadWidget:new(viewNode, false, true))
end

function ClubBattleUIMediator:stepLeftHead()
	local header = self:getView():getChildByName("header")
	local leftHead = header:getChildByName("leftHead")
	local content = leftHead:getChildByName("content")

	content:getChildByName("mpbar"):setVisible(false)
	content:getChildByName("hpbar"):setVisible(false)
	content:getChildByName("hpbg"):setVisible(false)
	content:getChildByName("img_hp"):setVisible(false)
	content:getChildByName("text_hp"):setVisible(false)
	content:getChildByName("text_hp_percent"):setVisible(false)
end
