-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterCutInMediator.lua

MasterCutInMediator = class("MasterCutInMediator", PopupViewMediator, _M)

function MasterCutInMediator:initialize()
	super.initialize(self)
end

function MasterCutInMediator:dispose()
	super.dispose(self)
end

function MasterCutInMediator:onRegister()
	super.onRegister(self)
end

function MasterCutInMediator:onTouchMaskLayer()
	return
end

function MasterCutInMediator:close()
	if self._closeCallBack then
		self._closeCallBack()
	end

	super.close(self)
end

function MasterCutInMediator:enterWithData(data)
	local master1 = self:getView():getChildByName("master1")
	local master2 = self:getView():getChildByName("master2")
	local animKey = "you_zhujuezhandou"

	if data.friend.leadStageLevel > data.enemy.leadStageLevel then
		animKey = "zuo_zhujuezhandou"
	elseif data.friend.leadStageLevel == data.enemy.leadStageLevel then
		animKey = "zhong_zhujuezhandou"
	end

	local anim = cc.MovieClip:create(animKey)
	local leftAnim = anim:getChildByFullName("left")
	local rightAnim = anim:getChildByFullName("right")

	anim:gotoAndPlay(0)

	self._closeCallBack = data.closeCallFunc

	anim:addTo(self:getView()):center(self:getView():getContentSize())

	local modelId_l = data.friend.waves[1].master.modelId
	local modelId_r = data.enemy.waves[1].master.modelId

	self:autoManageObject(self:getInjector():injectInto(MasterLeadStageKuang:new(master1, {
		stageId = data.friend.leadStageId,
		stageLevel = data.friend.leadStageLevel,
		modelId = modelId_l
	})))
	self:autoManageObject(self:getInjector():injectInto(MasterLeadStageKuang:new(master2, {
		stageId = data.enemy.leadStageId,
		stageLevel = data.enemy.leadStageLevel,
		modelId = modelId_r
	})))
	self:getView():getChildByName("mask"):addClickEventListener(function()
		self:close()
	end)
	anim:addCallbackAtFrame(7, function()
		AudioEngine:getInstance():playEffect("Se_Effect_BYYYC_Hit", false)
	end)
	master1:changeParent(anim:getChildByFullName("left.content")):center(anim:getChildByFullName("left.content"):getContentSize())
	master2:changeParent(anim:getChildByFullName("right.content")):center(anim:getChildByFullName("right.content"):getContentSize())
	master1:offset(-25, 0)
	master2:offset(0, 0)

	if data.title then
		local label = ccui.Text:create(data.title, TTF_FONT_FZYH_M, 22)

		label:addTo(anim:getChildByFullName("title")):center(anim:getChildByFullName("title"):getContentSize())
		label:offset(-10, 0)
	end

	anim:addCallbackAtFrame(50, function()
		self:close()
	end)
end
