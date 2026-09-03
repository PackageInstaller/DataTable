-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tests/view/Test3DEffect.lua

local function testSkyBox(mainScene)
	local mainCamera = cc.Camera:create()

	mainCamera:setCameraFlag(cc.CameraFlag.USER1)

	local cameraBackgroundBrush = cc.CameraBackgroundBrush:createSkyboxBrush("testAsset/left.jpg", "testAsset/right.jpg", "testAsset/top.jpg", "testAsset/bottom.jpg", "testAsset/front.jpg", "testAsset/back.jpg")

	mainCamera:setBackgroundBrush(cameraBackgroundBrush)
	mainCamera:initPerspective(60, 1.775, 5, 500)
	mainCamera:setPosition3D(cc.vec3(0, 45, 150))
	mainCamera:lookAt(cc.vec3(0, 0, 0), cc.vec3(0, 1, 0))
	mainScene:addChild(mainCamera)

	return mainCamera
end

local function testCamera(mainScene, userCamera)
	local _lastPostion
	local _angle = 0
	local _defEye = 0

	local function onTouchBegin(touch, event)
		_lastPostion = touch:getLocationInView()

		return true
	end

	local function onTouchMove(touch, event)
		local _touch = touch
		local pos = _touch:getLocationInView()
		local lastPos = _lastPostion
		local deltaX = (pos.x - lastPos.x) / 5

		_angle = _angle + deltaX * 0.01745329252

		userCamera:setPosition3D(cc.vec3(150 * math.sin(_angle), 45, 150 * math.cos(_angle)))

		local deltaY = (pos.y - lastPos.y) / 1.5

		_defEye = _defEye + deltaY

		if _defEye > 35 then
			_defEye = 35
		end

		if _defEye < -20 then
			_defEye = -20
		end

		userCamera:lookAt(cc.vec3(0, _defEye, 0), cc.vec3(0, 1, 0))

		_lastPostion = pos

		return true
	end

	local function onTouchEnd(touch, event)
		local _touch = touch

		_lastPostion = _touch:getLocationInView()

		return true
	end

	local listener = cc.EventListenerTouchOneByOne:create()

	listener:registerScriptHandler(onTouchBegin, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchMove, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnd, cc.Handler.EVENT_TOUCH_ENDED)
	mainScene:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, mainScene)
end

local function testSprite3D(mainScene)
	local sprite3D = cc.Sprite3D:create("testAsset/succubus.c3t")

	sprite3D:setScale(0.4)
	mainScene:addChild(sprite3D)
	sprite3D:setPosition3D(cc.vec3(0, -50, 0))
	sprite3D:setCameraMask(cc.CameraFlag.USER1)
end

local function main()
	local newScene = cc.Scene:create()
	local director = cc.Director:getInstance()

	if director:getRunningScene() then
		director:replaceScene(newScene)
	else
		director:runWithScene(newScene)
	end

	local userCamera = testSkyBox(newScene)

	testCamera(newScene, userCamera)
	testSprite3D(newScene, userCamera)
end

main()
