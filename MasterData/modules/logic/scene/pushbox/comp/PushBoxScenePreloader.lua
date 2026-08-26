-- chunkname: @modules/logic/scene/pushbox/comp/PushBoxScenePreloader.lua

module("modules.logic.scene.pushbox.comp.PushBoxScenePreloader", package.seeall)

local PushBoxScenePreloader = class("PushBoxScenePreloader", BaseSceneComp)

function PushBoxScenePreloader:onInit()
	self._scene = self:getCurScene()
end

function PushBoxScenePreloader:startPreload(second)
	self.loader = MultiAbLoader.New()

	self.loader:addPath(ResUrl.getPushBoxPre("pushboxmainpre"))

	for k, v in pairs(self:getElementType2Url()) do
		if not tabletool.indexOf(self.loader._pathList, v) then
			self.loader:addPath(v)
		end
	end

	self.loader:startLoad(self._onAssetLoaded, self)
end

function PushBoxScenePreloader:_onAssetLoaded()
	self._scene_obj = gohelper.clone(self.loader:getAssetItem(ResUrl.getPushBoxPre("pushboxmainpre")):GetResource(), self._scene:getSceneContainerGO())
	self._scene_obj.name = "Root"

	transformhelper.setLocalPos(self._scene_obj.transform, 0, 0, -5)

	for k, v in pairs(self:getElementType2Url()) do
		gohelper.clone(self.loader:getAssetItem(v):GetResource(), gohelper.findChild(self._scene_obj, "OriginElement")).name = k
	end

	local back_ground = gohelper.clone(self.loader:getAssetItem(self:getElementType2Url().Background):GetResource(), self._scene_obj)
	local meshRenderer = back_ground.transform:GetChild(0):GetComponent("MeshRenderer")

	meshRenderer.sortingOrder = -10

	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true
	camera.orthographicSize = 7.5

	self._scene.director:onPushBoxAssetLoadFinish()
end

function PushBoxScenePreloader:getAssetItem(url)
	return self.loader:getAssetItem(url):GetResource()
end

function PushBoxScenePreloader:onSceneClose()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographicSize = 5
	camera.orthographic = false

	if self.loader then
		self.loader:dispose()
	end

	if self._scene_obj then
		gohelper.destroy(self._scene_obj)
	end
end

function PushBoxScenePreloader:getElementType2Url()
	return {
		[PushBoxGameMgr.ElementType.Goal] = ResUrl.getPushBoxPre("men_1x1_a"),
		[PushBoxGameMgr.ElementType.Empty] = ResUrl.getPushBoxPre("diban_a"),
		[PushBoxGameMgr.ElementType.Box] = ResUrl.getPushBoxPre("xiangzi_1x1_a"),
		[PushBoxGameMgr.ElementType.Mechanics] = ResUrl.getPushBoxPre("jiguanup_1x1_a"),
		[PushBoxGameMgr.ElementType.Fan] = ResUrl.getPushBoxPre("paifengshan_1x1_a"),
		[PushBoxGameMgr.ElementType.Road] = ResUrl.getPushBoxPre("diban_a"),
		[PushBoxGameMgr.ElementType.LightUp] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_c"),
		[PushBoxGameMgr.ElementType.LightDown] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_d"),
		[PushBoxGameMgr.ElementType.LightLeft] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_a"),
		[PushBoxGameMgr.ElementType.LightRight] = ResUrl.getPushBoxPre("tanzhaodeng_1x1_b"),
		[PushBoxGameMgr.ElementType.WallUp] = ResUrl.getPushBoxPre("qiang_1x1_a"),
		[PushBoxGameMgr.ElementType.WallPicUp1] = ResUrl.getPushBoxPre("qiang_1x1_b"),
		[PushBoxGameMgr.ElementType.WallPicUp2] = ResUrl.getPushBoxPre("qiang_1x1_c"),
		[PushBoxGameMgr.ElementType.WallRight] = ResUrl.getPushBoxPre("qiang_1x1_e01"),
		[PushBoxGameMgr.ElementType.WallLeft] = ResUrl.getPushBoxPre("qiang_1x1_e"),
		[PushBoxGameMgr.ElementType.WallUpDoublePic1] = ResUrl.getPushBoxPre("qiang_1x2_f"),
		[PushBoxGameMgr.ElementType.WallUpDoublePic2] = ResUrl.getPushBoxPre("qiang_1x2_g"),
		[PushBoxGameMgr.ElementType.WallLeft2] = ResUrl.getPushBoxPre("qiang_1x1_d"),
		[PushBoxGameMgr.ElementType.WallRight2] = ResUrl.getPushBoxPre("qiang_1x1_d01"),
		[PushBoxGameMgr.ElementType.WallCornerTopLeft] = ResUrl.getPushBoxPre("wuyan_1×1_a2"),
		[PushBoxGameMgr.ElementType.WallCornerTopRight] = ResUrl.getPushBoxPre("wuyan_1×1_a1"),
		[PushBoxGameMgr.ElementType.WallCornerBottomLeft] = ResUrl.getPushBoxPre("wuyan_1×1_b2"),
		[PushBoxGameMgr.ElementType.WallCornerBottomRight] = ResUrl.getPushBoxPre("wuyan_1×1_b1"),
		EnemyUp = ResUrl.getPushBoxPre("baoan_1x1_c"),
		EnemyDown = ResUrl.getPushBoxPre("baoan_1x1_d"),
		EnemyLeft = ResUrl.getPushBoxPre("baoan_1x1_a"),
		EnemyRight = ResUrl.getPushBoxPre("baoan_1x1_b"),
		CharacterUp = ResUrl.getPushBoxPre("meilaini_1x1_c"),
		CharacterDown = ResUrl.getPushBoxPre("meilaini_1x1_a"),
		CharacterLeft = ResUrl.getPushBoxPre("meilaini_1x1_b"),
		CharacterRight = ResUrl.getPushBoxPre("meilaini_1x1_d"),
		DoorOpen = ResUrl.getPushBoxPre("men_1x1_b"),
		EnabledMechanics = ResUrl.getPushBoxPre("jiguandown_1x1_a"),
		Background = ResUrl.getPushBoxPre("background"),
		diban_b = ResUrl.getPushBoxPre("diban_b"),
		diban_c = ResUrl.getPushBoxPre("diban_c"),
		diban_d = ResUrl.getPushBoxPre("diban_d")
	}
end

return PushBoxScenePreloader
