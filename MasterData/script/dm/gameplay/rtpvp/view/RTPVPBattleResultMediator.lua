-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/view/RTPVPBattleResultMediator.lua

RTPVPBattleResultMediator = class("RTPVPBattleResultMediator", DmPopupViewMediator)

function RTPVPBattleResultMediator:initialize()
	super.initialize(self)
end

function RTPVPBattleResultMediator:dispose()
	super.dispose(self)
end

function RTPVPBattleResultMediator:enterWithData(data)
	local isPass = data.isPass
	local resultView = ccui.ImageView:create()
	local plistType = ccui.TextureResType.plistType

	if isPass then
		resultView:loadTexture("img_kof_win.png", plistType)
	else
		resultView:loadTexture("img_kof_lose.png", plistType)
	end

	resultView:setPosition(display.center)
	resultView:addTo(self:getView())
end

function RTPVPBattleResultMediator:onTouchMaskLayer()
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "rtpvpMatch"))
end
