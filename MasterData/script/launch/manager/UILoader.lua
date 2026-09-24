local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert
local var_0_3 = string.format
local var_0_4 = table.insert
local var_0_5 = table.remove
local var_0_6 = tolua_xbask
local var_0_7 = get_millisecond
local var_0_8 = lx.Time
local var_0_9 = gamecore
local var_0_10 = typeof
local var_0_11 = gamecore.ResourceLoader
local var_0_13 = {
	["UnityEngine.MeshFilter"] = "MeshFilter",
	["UnityEngine.TrailRenderer"] = "TrailRenderer",
	["UnityEngine.Animator"] = "Animator",
	["UnityEngine.Video.VideoPlayer"] = "VideoPlayer",
	["UnityEngine.Animation"] = "Animation",
	["UnityEngine.RectTransform"] = "RectTransform",
	["UnityEngine.Camera"] = "Camera",
	["UnityEngine.MeshRenderer"] = "MeshRenderer",
	["UnityEngine.CanvasGroup"] = "CanvasGroup",
	["UnityEngine.MeshCollider"] = "MeshCollider",
	["UnityEngine.ParticleSystem"] = "ParticleSystem",
	["UnityEngine.BoxCollider2D"] = "BoxCollider2D",
	["UnityEngine.ParticleSystemRenderer"] = "ParticleSystemRenderer",
	["UnityEngine.AudioSource"] = "AudioSource",
	["UnityEngine.Collider2D"] = "Collider2D",
	["UnityEngine.CanvasRenderer"] = "CanvasRenderer",
	["UnityEngine.Transform"] = "Transform",
	["UnityEngine.FlareLayer"] = "FlareLayer",
	["UnityEngine.Canvas"] = "Canvas",
	["UnityEngine.Rigidbody2D"] = "Rigidbody2D"
}

local function var_0_14(arg_1_0, arg_1_1)
	if arg_1_0 and not arg_1_0:Equals(nil) then
		arg_1_0:SetActive(arg_1_1)
	end
end

local function var_0_15(arg_2_0)
	local var_2_0 = arg_2_0:match("%.([^%.]+)$")

	if var_2_0 then
		arg_2_0 = var_2_0
	end

	local var_2_1 = arg_2_0:sub(1, 1)

	arg_2_0 = arg_2_0:sub(2)

	return var_2_1:lower() .. arg_2_0
end

lx.define_class("ui_base", function(arg_3_0)
	function arg_3_0:getID()
		return self._id_
	end

	function arg_3_0:getUIName()
		return self._ui_name
	end

	function arg_3_0:autoKillDOTween(arg_6_1)
		var_0_4(self._do_tween_list, arg_6_1)

		return arg_6_1
	end

	function arg_3_0:loadUI(arg_7_1, arg_7_2)
		local var_7_0 = self._mgr_:__load_ui(arg_7_1)

		self._children[var_7_0:getID()] = var_7_0

		self._mgr_:__remove_object(var_7_0:getID())

		if arg_7_2 then
			var_7_0._panel.transform:SetParent(arg_7_2)
		end

		var_7_0:__setParent(self)

		return var_7_0
	end

	function arg_3_0:loadUIPrefab(arg_8_1, arg_8_2)
		local var_8_0 = self._mgr_:__load_ui_prefab(arg_8_1)

		self._children[var_8_0:getID()] = var_8_0

		self._mgr_:__remove_object(var_8_0:getID())

		if arg_8_2 then
			var_8_0._panel.transform:SetParent(arg_8_2)
		end

		var_8_0:__setParent(self)

		return var_8_0, var_8_0._control
	end

	function arg_3_0:destroyChildren(arg_9_1)
		local var_9_0 = {}
		local var_9_1

		for iter_9_0, iter_9_1 in pairs(self._children) do
			if iter_9_1:getUIName() == arg_9_1 then
				var_9_0[iter_9_0] = iter_9_1
				var_9_1 = true
			end
		end

		for iter_9_2, iter_9_3 in pairs(var_9_0) do
			self._children[iter_9_2] = nil

			iter_9_3:destroy()
		end

		return var_9_1
	end

	function arg_3_0:destroy()
		self:__release_children()
		self._mgr_:__remove_from_showing(self._ui_name)
		self:__removeFromParent()
		self:__onDestroy()
		self:__release_do_tween()
		self:__release_listener()
		self:__release_peer()
		self:__release_control()
		self._mgr_:__remove_object(self._id_)
		var_0_11:destroyGameObject(self._panel)

		self._panel = nil
		self._parent = nil
		self._ui_panel = nil
		self._control = nil
		self._children = nil
		self._canvas_set = nil
		self._rule_ = nil

		local var_10_0 = self._mgr_:__get_ui_path(self._ui_name)

		if var_10_0 then
			var_0_11:unloadAsset(var_10_0)
		end

		self:__release_resources()

		self._loaded_asset_set = nil

		self._mgr_:__profile_end((self._mgr_:__profile_begin(var_0_3("ui [%s](%s) destroy", self._ui_name, self._id_))))

		self._mgr_ = nil

		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(self) do
			var_0_4(var_10_1, iter_10_0)
		end

		for iter_10_2, iter_10_3 in pairs(var_10_1) do
			self[iter_10_3] = nil
		end
	end

	function arg_3_0:__release_control()
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(self._control) do
			var_11_0[iter_11_0] = iter_11_0
		end

		for iter_11_2 in pairs(var_11_0) do
			self._control[iter_11_2] = nil
		end
	end

	function arg_3_0:__release_peer()
		for iter_12_0, iter_12_1 in pairs(self._peer_list) do
			local var_12_0 = {}

			for iter_12_2 in pairs(iter_12_1.peer) do
				var_12_0[iter_12_2] = iter_12_2
			end

			for iter_12_3 in pairs(var_12_0) do
				iter_12_1.peer[iter_12_3] = nil
			end

			iter_12_1.o = nil
			iter_12_1.peer = nil
		end

		self._peer_list = {}
	end

	function arg_3_0:__release_listener()
		for iter_13_0, iter_13_1 in pairs(self._listener_list) do
			iter_13_1.o:RemoveAllListeners()

			iter_13_1.o = nil
			iter_13_1.func = nil
		end

		self._listener_list = {}
	end

	function arg_3_0:__add_listener(arg_14_1, arg_14_2, arg_14_3)
		local function var_14_0(...)
			local var_15_0, var_15_1 = xpcall(arg_14_3, debug.traceback, ...)

			if not var_15_0 then
				log.errorlog(var_15_1)
			end
		end

		arg_14_1[arg_14_2]:AddListener(var_14_0)
		var_0_4(self._listener_list, {
			o = arg_14_1[arg_14_2],
			func = var_14_0
		})
	end

	function arg_3_0:__release_do_tween()
		for iter_16_0, iter_16_1 in pairs(self._do_tween_list) do
			iter_16_1:Kill()
		end

		self._do_tween_list = {}
	end

	function arg_3_0:__release_children()
		for iter_17_0, iter_17_1 in pairs(self._children) do
			iter_17_1:destroy()
		end

		self._children = {}
	end

	function arg_3_0:__release_resources()
		for iter_18_0, iter_18_1 in pairs(self._loaded_asset_set) do
			for iter_18_2 = 1, iter_18_1 do
				var_0_11:unloadAsset(iter_18_0)
			end
		end

		self._loaded_asset_set = {}
	end

	function arg_3_0:__on_load_asset(arg_19_1)
		if not arg_19_1 then
			return
		end

		local var_19_0

		if self._loaded_asset_set then
			var_19_0 = self._loaded_asset_set[arg_19_1] or 0
		else
			return
		end

		self._loaded_asset_set[arg_19_1] = var_19_0 + 1
	end

	function arg_3_0.destroyGameObject(arg_20_0, arg_20_1)
		var_0_11:destroyGameObject(arg_20_1)
	end

	function arg_3_0:createGameObject(arg_21_1)
		self:__on_load_asset(arg_21_1)

		return var_0_11:createGameObject(arg_21_1)
	end

	function arg_3_0:loadTexture(arg_22_1)
		self:__on_load_asset(arg_22_1)

		return var_0_11:loadTexture(arg_22_1)
	end

	function arg_3_0:loadTexture2D(arg_23_1)
		self:__on_load_asset(arg_23_1)

		return var_0_11:loadTexture2D(arg_23_1)
	end

	function arg_3_0:loadSprite(arg_24_1)
		local var_24_0, var_24_1, var_24_2 = var_0_11:loadSprite(arg_24_1)

		self:__on_load_asset(var_24_1)

		return var_24_0, var_24_2, var_24_1
	end

	function arg_3_0:loadMaterial(arg_25_1)
		if not self:findPath(arg_25_1) then
			arg_25_1 = string.find(arg_25_1, "data_extra") and "data_extra/ship/spine/1/Ship_girl_1_Material.mat" or "data/cookbook/spine/ship/1/Q_1_Material.mat"
		end

		self:__on_load_asset(arg_25_1)

		return var_0_11:loadMaterial(arg_25_1)
	end

	function arg_3_0:loadAnimationClip(arg_26_1)
		self:__on_load_asset(arg_26_1)

		return var_0_11:loadAnimationClip(arg_26_1)
	end

	function arg_3_0:loadAnimatorController(arg_27_1)
		self:__on_load_asset(arg_27_1)

		return var_0_11:loadAnimatorController(arg_27_1)
	end

	function arg_3_0:loadVideoClip(arg_28_1)
		self:__on_load_asset(arg_28_1)

		return var_0_11:loadVideoClip(arg_28_1)
	end

	function arg_3_0:loadAudioClip(arg_29_1)
		self:__on_load_asset(arg_29_1)

		return var_0_11:loadAudioClip(arg_29_1)
	end

	function arg_3_0:playCV(arg_30_1, arg_30_2, arg_30_3)
		self:__on_load_asset((var_0_9.AudioManager:playCV(arg_30_1, arg_30_2, arg_30_3)))
	end

	function arg_3_0:playBackgroundMusic(arg_31_1, arg_31_2)
		local var_31_0, var_31_1 = var_0_9.AudioManager:playBackgroundMusic(arg_31_1, arg_31_2)

		self:__on_load_asset(var_31_0)

		if arg_31_2 == nil then
			self:set_bgm_loop(true)
		else
			self:set_bgm_loop(arg_31_2)
		end

		return var_31_1
	end

	function arg_3_0:playSE(arg_32_1, arg_32_2)
		self:__on_load_asset((var_0_9.AudioManager:playSE(arg_32_1, arg_32_2)))
	end

	function arg_3_0.set_bgm_loop(arg_33_0, arg_33_1)
		local var_33_0 = var_0_9.AudioManager:set_bgm_loop(arg_33_1)
	end

	function arg_3_0:loadSkeletonDataAsset(arg_34_1)
		if not self:findPath(arg_34_1) then
			arg_34_1 = string.find(arg_34_1, "data_extra") and "data_extra/ship/spine/1/Ship_girl_1_SkeletonData.asset" or "data/cookbook/spine/ship/1/Q_1_SkeletonData.asset"
		end

		self:__on_load_asset(arg_34_1)

		return var_0_11:loadSkeletonDataAsset(arg_34_1)
	end

	function arg_3_0:loadTextAsset(arg_35_1)
		self:__on_load_asset(arg_35_1)

		return var_0_11:loadTextAsset(arg_35_1)
	end

	function arg_3_0:loadFont(arg_36_1)
		self:__on_load_asset(arg_36_1)

		return var_0_11:loadFont(arg_36_1)
	end

	function arg_3_0:loadRuntimeAnimatorController(arg_37_1)
		self:__on_load_asset(arg_37_1)

		return var_0_11:loadRuntimeAnimatorController(arg_37_1)
	end

	function arg_3_0.findPath(arg_38_0, arg_38_1)
		return var_0_11:findPath(arg_38_1)
	end

	function arg_3_0.convertToJP(arg_39_0, arg_39_1, arg_39_2)
		return var_0_11:convertToJP(arg_39_1, arg_39_2)
	end

	function arg_3_0:setVisible(arg_40_1, ...)
		self:__onVisible(arg_40_1, ...)
		self._mgr_:__set_layer(arg_40_1, self._ui_name, self._base_canvas, self._canvas_set)
		var_0_14(self._panel, arg_40_1)

		self._is_visible = arg_40_1

		self._mgr_:__profile_end(self._mgr_:__profile_begin(var_0_3("ui [%s] to [%s] setVisible", self._ui_name, tostring(arg_40_1))), 33)
	end

	function arg_3_0:isVisible()
		return self._is_visible
	end

	function arg_3_0:__registerControl(arg_42_1, arg_42_2, arg_42_3)
		arg_42_3 = arg_42_3 or arg_42_1

		local var_42_0 = self._rule_.none[arg_42_1]

		if not self._rule_.none[arg_42_1] then
			var_42_0 = {
				set = {}
			}
			self._rule_.none[arg_42_1] = var_42_0
		end

		var_42_0.set[arg_42_3] = {
			tp = arg_42_2
		}
	end

	function arg_3_0:__registerClickEvent(arg_43_1)
		self._rule_.click[arg_43_1] = 0
	end

	function arg_3_0:__update__(arg_44_1)
		if not self._is_visible then
			return
		end

		self:__onUpdate(arg_44_1)
	end

	function arg_3_0:__reset__()
		for iter_45_0, iter_45_1 in pairs(self._children) do
			iter_45_1:__reset__()
		end

		self:__onReset()
		self:__release_do_tween()
		self:__release_resources()
	end

	function arg_3_0:__setParent(arg_46_1)
		if self._parent then
			var_0_0.error(var_0_3("[%s] already has parent.", self._ui_name))
		end

		self._parent = arg_46_1
	end

	function arg_3_0:__removeFromParent()
		if not self._parent then
			return
		end

		self._parent:__removeChild(self:getID())

		self._parent = nil
	end

	function arg_3_0:__removeChild(arg_48_1)
		self._children[arg_48_1] = nil
	end

	function arg_3_0.__onLoadFinish(arg_49_0)
		return
	end

	function arg_3_0.__onDestroy(arg_50_0)
		return
	end

	function arg_3_0.__onVisible(arg_51_0, arg_51_1, ...)
		return
	end

	function arg_3_0.__onUpdate(arg_52_0, ...)
		return
	end

	function arg_3_0.__onReset(arg_53_0)
		return
	end

	function arg_3_0:__load(arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5)
		self._mgr_:__profile_end((self._mgr_:__profile_begin(var_0_3("ui [%s](%s) load", arg_54_2, self._id_))))

		return (self:__real_load(arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5))
	end

	function arg_3_0:__real_load(arg_55_1, arg_55_2, arg_55_3, arg_55_4, arg_55_5)
		self._panel = var_0_11:createGameObject(arg_55_3)

		if not self._panel then
			log.errorlog(var_0_3("create ui failed, name:%s, path:%s", arg_55_2, arg_55_3))

			return false
		end

		self._ui_name = arg_55_2
		self._ui_panel = self._panel:GetComponent(var_0_10(UnityEngine.RectTransform))

		self._panel.transform:SetParent(arg_55_1, false)

		self._panel.transform.localScale = Vector3.one
		self._panel.transform.localPosition = Vector3.zero
		self._base_canvas = self._panel.transform:GetComponent("Canvas")

		var_0_14(self._panel)

		if arg_55_4 then
			if not self:__bind_generate_rule(arg_55_2, self._panel.transform, arg_55_4._rule_, arg_55_5) then
				return false
			end
		elseif not self:__bind_rule(arg_55_2, self._panel.transform, self._rule_) then
			return false
		end

		self:__onLoadFinish()

		return true
	end

	function arg_3_0:__bind_the_control(arg_56_1, arg_56_2, arg_56_3, arg_56_4, arg_56_5)
		local var_56_0 = arg_56_2:Find(arg_56_5.path)

		if not var_56_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_56_1, arg_56_5.path))

			return
		end

		local var_56_1 = var_56_0.gameObject

		arg_56_3[arg_56_4] = var_56_0.gameObject

		if tolua.getpeer(var_56_1) == nil then
			local var_56_2 = {}

			tolua.setpeer(var_56_1, var_56_2)
			var_0_4(self._peer_list, {
				o = var_56_1,
				peer = var_56_2
			})
		end

		for iter_56_0, iter_56_1 in pairs(arg_56_5.component) do
			local var_56_3 = var_0_13[iter_56_1] or iter_56_1
			local var_56_4 = var_56_1:GetComponent(var_56_3)

			if not var_56_4 then
				log.errorlog(var_0_3("%s GetComponent failed, Component '%s'!", arg_56_5.path, var_56_3))
			end

			var_56_1[var_0_15(iter_56_1)] = var_56_4
		end

		for iter_56_2, iter_56_3 in pairs(arg_56_5.list) do
			self:__bind_the_control(arg_56_1, arg_56_2, var_56_1, iter_56_2, iter_56_3)
		end
	end

	function arg_3_0.__bind_control_canvas_set(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5)
		local var_57_0 = arg_57_2:Find(arg_57_5.path)
		local var_57_1

		if not var_57_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_57_1, arg_57_5.path))

			do return end

			var_57_1 = {
				diff_order = 100
			}
		end

		var_57_1.canvas = var_57_0.gameObject

		var_0_4(arg_57_3, var_57_1)
	end

	function arg_3_0:__bind_control_click(arg_58_1, arg_58_2, arg_58_3, arg_58_4)
		local var_58_0 = arg_58_2:Find(arg_58_3)

		if not var_58_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_58_1, arg_58_3))

			return
		end

		self:__add_listener(var_58_0:GetComponent(arg_58_4.tp), "onClick", (self:__make_event_func((arg_58_3:gsub("/", "_")))))
	end

	function arg_3_0:__bind_control_scale_btn_click(arg_59_1, arg_59_2, arg_59_3, arg_59_4)
		local var_59_0 = arg_59_2:Find(arg_59_3)

		if not var_59_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_59_1, arg_59_3))

			return
		end

		self:__add_listener(var_59_0:GetComponent(arg_59_4.tp), "onClick", (self:__make_event_func(arg_59_3:gsub("/", "_"), "onScaleButtonClick")))
	end

	function arg_3_0:__bind_control_toggle(arg_60_1, arg_60_2, arg_60_3, arg_60_4)
		local var_60_0 = arg_60_2:Find(arg_60_3)

		if not var_60_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_60_1, arg_60_3))

			return
		end

		local var_60_1 = arg_60_3:gsub("/", "_")
		local var_60_2 = var_60_0:GetComponent(arg_60_4.tp)
		local var_60_3 = self:__make_event_func(var_60_1, "onToggle")
		local var_60_4 = self:__make_event_func_probably_null(var_60_1, "onToggle_all_do")

		if var_60_4 then
			self:__add_listener(var_60_2, "onValueChanged", function(arg_61_0)
				var_60_4(arg_61_0)
			end)
		else
			self:__add_listener(var_60_2, "onValueChanged", function(arg_62_0)
				if arg_62_0 then
					var_60_3()
				end
			end)
		end
	end

	function arg_3_0:__bind_control_drag(arg_63_1, arg_63_2, arg_63_3, arg_63_4)
		local var_63_0 = arg_63_2:Find(arg_63_3)

		if not var_63_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_63_1, arg_63_3))

			return
		end

		local var_63_1 = arg_63_3:gsub("/", "_")
		local var_63_2 = var_63_0:GetComponent(arg_63_4.tp)

		self:__add_listener(var_63_2, "onBeginDrag", (self:__make_event_func(var_63_1, "onBeginDrag")))
		self:__add_listener(var_63_2, "onDrag", (self:__make_event_func(var_63_1, "onDrag")))
		self:__add_listener(var_63_2, "onEndDrag", (self:__make_event_func(var_63_1, "onEndDrag")))
	end

	function arg_3_0:__bind_control_click_and_long_click_and_pointer_up(arg_64_1, arg_64_2, arg_64_3, arg_64_4)
		local var_64_0 = arg_64_2:Find(arg_64_3)

		if not var_64_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_64_1, arg_64_3))

			return
		end

		local var_64_1 = arg_64_3:gsub("/", "_")
		local var_64_2 = var_64_0:GetComponent(arg_64_4.tp)

		self:__add_listener(var_64_2, "onClick", (self:__make_event_func(var_64_1)))
		self:__add_listener(var_64_2, "onLongClick", (self:__make_event_func(var_64_1, "onLongClick")))
		self:__add_listener(var_64_2, "onPointerUp", (self:__make_event_func(var_64_1, "onPointerUp")))
	end

	function arg_3_0:__bind_control_long_click_drag_and_pointer_up(arg_65_1, arg_65_2, arg_65_3, arg_65_4)
		local var_65_0 = arg_65_2:Find(arg_65_3)

		if not var_65_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_65_1, arg_65_3))

			return
		end

		local var_65_1 = arg_65_3:gsub("/", "_")
		local var_65_2 = var_65_0:GetComponent(arg_65_4.tp)

		self:__add_listener(var_65_2, "onLongClick", (self:__make_event_func(var_65_1, "onLongClick")))
		self:__add_listener(var_65_2, "onPointerEnter", (self:__make_event_func(var_65_1, "onPointerEnter")))
		self:__add_listener(var_65_2, "onPointerUp", (self:__make_event_func(var_65_1, "onPointerUp")))
	end

	function arg_3_0:__bind_control_pointer_down_and_long_click(arg_66_1, arg_66_2, arg_66_3, arg_66_4)
		local var_66_0 = arg_66_2:Find(arg_66_3)

		if not var_66_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_66_1, arg_66_3))

			return
		end

		local var_66_1 = arg_66_3:gsub("/", "_")
		local var_66_2 = var_66_0:GetComponent(arg_66_4.tp)

		self:__add_listener(var_66_2, "onPointerDown", (self:__make_event_func(var_66_1, "onPointerDown")))
		self:__add_listener(var_66_2, "onLongClick", (self:__make_event_func(var_66_1, "onLongClick")))
	end

	function arg_3_0:__bind_control_uni_web_view(arg_67_1, arg_67_2, arg_67_3, arg_67_4)
		local var_67_0 = arg_67_2:Find(arg_67_3)

		if not var_67_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_67_1, arg_67_3))

			return
		end

		local var_67_1 = arg_67_3:gsub("/", "_")
		local var_67_2 = var_67_0:GetComponent(arg_67_4.tp)

		self:__add_listener(var_67_2, "onPointerDown", (self:__make_event_func(var_67_1, "doLoad")))
		self:__add_listener(var_67_2, "onLongClick", (self:__make_event_func(var_67_1, "doUpdateFrame")))
	end

	function arg_3_0:__bind_control_click_and_long_click(arg_68_1, arg_68_2, arg_68_3, arg_68_4)
		local var_68_0 = arg_68_2:Find(arg_68_3)

		if not var_68_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_68_1, arg_68_3))

			return
		end

		local var_68_1 = arg_68_3:gsub("/", "_")
		local var_68_2 = var_68_0:GetComponent(arg_68_4.tp)

		self:__add_listener(var_68_2, "onClick", (self:__make_event_func(var_68_1)))
		self:__add_listener(var_68_2, "onLongClick", (self:__make_event_func(var_68_1, "onLongClick")))
	end

	function arg_3_0:__bind_control_switch_by_drag(arg_69_1, arg_69_2, arg_69_3, arg_69_4)
		local var_69_0 = arg_69_2:Find(arg_69_3)

		if not var_69_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_69_1, arg_69_3))

			return
		end

		local var_69_1 = arg_69_3:gsub("/", "_")
		local var_69_2 = var_69_0:GetComponent(arg_69_4.tp)

		self:__add_listener(var_69_2, "onLeftDragEnd", (self:__make_event_func(var_69_1, "onLeftDragEnd")))
		self:__add_listener(var_69_2, "onRightDragEnd", (self:__make_event_func(var_69_1, "onRightDragEnd")))
	end

	function arg_3_0:__bind_control_pointer_down_up(arg_70_1, arg_70_2, arg_70_3, arg_70_4)
		local var_70_0 = arg_70_2:Find(arg_70_3)

		if not var_70_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_70_1, arg_70_3))

			return
		end

		local var_70_1 = arg_70_3:gsub("/", "_")
		local var_70_2 = var_70_0:GetComponent(arg_70_4.tp)

		self:__add_listener(var_70_2, "onPointerDown", (self:__make_event_func(var_70_1, "onPointerDown")))
		self:__add_listener(var_70_2, "onPointerUp", (self:__make_event_func(var_70_1, "onPointerUp")))

		if arg_70_1 == "furniture" then
			self:__add_listener(var_70_2, "onPointerClick", (self:__make_event_func(var_70_1, "onPointerClick")))
		end
	end

	function arg_3_0:__bind_control_pointer_enter_exit(arg_71_1, arg_71_2, arg_71_3, arg_71_4)
		local var_71_0 = arg_71_2:Find(arg_71_3)

		if not var_71_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_71_1, arg_71_3))

			return
		end

		local var_71_1 = arg_71_3:gsub("/", "_")
		local var_71_2 = var_71_0:GetComponent(arg_71_4.tp)

		self:__add_listener(var_71_2, "onPointerEnter", (self:__make_event_func(var_71_1, "onPointerEnter")))
		self:__add_listener(var_71_2, "onPointerExit", (self:__make_event_func(var_71_1, "onPointerExit")))
	end

	function arg_3_0:__bind_control_click_drag(arg_72_1, arg_72_2, arg_72_3, arg_72_4)
		local var_72_0 = arg_72_2:Find(arg_72_3)

		if not var_72_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_72_1, arg_72_3))

			return
		end

		self:__add_listener(var_72_0:GetComponent(arg_72_4.tp), "onClick", (self:__make_event_func((arg_72_3:gsub("/", "_")))))
	end

	function arg_3_0:__bind_control_dropdown(arg_73_1, arg_73_2, arg_73_3, arg_73_4)
		local var_73_0 = arg_73_2:Find(arg_73_3)

		if not var_73_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_73_1, arg_73_3))

			return
		end

		self:__add_listener(var_73_0:GetComponent(arg_73_4.tp), "onValueChanged", (self:__make_event_func(arg_73_3:gsub("/", "_"), "onDropDown")))
	end

	function arg_3_0:__bind_control_trigger_2d(arg_74_1, arg_74_2, arg_74_3, arg_74_4)
		local var_74_0 = arg_74_2:Find(arg_74_3)

		if not var_74_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_74_1, arg_74_3))

			return
		end

		local var_74_1 = arg_74_3:gsub("/", "_")
		local var_74_2 = var_74_0:GetComponent(arg_74_4.tp)

		self:__add_listener(var_74_2, "onTriggerEnter2D", (self:__make_event_func(var_74_1, "onTriggerEnter2D")))
		self:__add_listener(var_74_2, "onTriggerStay2D", (self:__make_event_func(var_74_1, "onTriggerStay2D")))
		self:__add_listener(var_74_2, "onTriggerExit2D", (self:__make_event_func(var_74_1, "onTriggerExit2D")))
	end

	function arg_3_0:__bind_control_ui_scroll_end(arg_75_1, arg_75_2, arg_75_3, arg_75_4)
		local var_75_0 = arg_75_2:Find(arg_75_3)

		if not var_75_0 then
			log.errorlog(var_0_3("%s Find %s failed!", arg_75_1, arg_75_3))

			return
		end

		self:__add_listener(var_75_0:GetComponent(arg_75_4.tp), "onScrollEndEvent", (self:__make_event_func(arg_75_3:gsub("/", "_"), "onScrollEndEvent")))
	end

	function arg_3_0:__bind_generate_rule(arg_76_1, arg_76_2, arg_76_3, arg_76_4)
		if arg_76_3.none then
			for iter_76_0, iter_76_1 in pairs(arg_76_3.none) do
				self:__bind_the_control(arg_76_1, arg_76_2, self._control, iter_76_0, iter_76_1)
			end
		end

		if arg_76_3.canvas_set and self._base_canvas then
			for iter_76_2, iter_76_3 in pairs(arg_76_3.canvas_set) do
				self:__bind_control_canvas_set(arg_76_1, arg_76_2, self._canvas_set, iter_76_2, iter_76_3)
			end
		end

		if arg_76_3.click and not arg_76_4 then
			for iter_76_4, iter_76_5 in pairs(arg_76_3.click) do
				self:__bind_control_click(arg_76_1, arg_76_2, iter_76_4, iter_76_5)
			end
		end

		if arg_76_3.scale_btn_click and not arg_76_4 then
			for iter_76_6, iter_76_7 in pairs(arg_76_3.scale_btn_click) do
				self:__bind_control_scale_btn_click(arg_76_1, arg_76_2, iter_76_6, iter_76_7)
			end
		end

		if arg_76_3.toggle and not arg_76_4 then
			for iter_76_8, iter_76_9 in pairs(arg_76_3.toggle) do
				self:__bind_control_toggle(arg_76_1, arg_76_2, iter_76_8, iter_76_9)
			end
		end

		if arg_76_3.drag and not arg_76_4 then
			for iter_76_10, iter_76_11 in pairs(arg_76_3.drag) do
				self:__bind_control_drag(arg_76_1, arg_76_2, iter_76_10, iter_76_11)
			end
		end

		if arg_76_3.click_and_long_click_and_pointer_up and not arg_76_4 then
			for iter_76_12, iter_76_13 in pairs(arg_76_3.click_and_long_click_and_pointer_up) do
				self:__bind_control_click_and_long_click_and_pointer_up(arg_76_1, arg_76_2, iter_76_12, iter_76_13)
			end
		end

		if arg_76_3.long_click_drag_and_pointer_up and not arg_76_4 then
			for iter_76_14, iter_76_15 in pairs(arg_76_3.long_click_drag_and_pointer_up) do
				self:__bind_control_long_click_drag_and_pointer_up(arg_76_1, arg_76_2, iter_76_14, iter_76_15)
			end
		end

		if arg_76_3.click_and_long_click and not arg_76_4 then
			for iter_76_16, iter_76_17 in pairs(arg_76_3.click_and_long_click) do
				self:__bind_control_click_and_long_click(arg_76_1, arg_76_2, iter_76_16, iter_76_17)
			end
		end

		if arg_76_3.switch_by_drag and not arg_76_4 then
			for iter_76_18, iter_76_19 in pairs(arg_76_3.switch_by_drag) do
				self:__bind_control_switch_by_drag(arg_76_1, arg_76_2, iter_76_18, iter_76_19)
			end
		end

		if arg_76_3.pointer_down_up and not arg_76_4 then
			for iter_76_20, iter_76_21 in pairs(arg_76_3.pointer_down_up) do
				self:__bind_control_pointer_down_up(arg_76_1, arg_76_2, iter_76_20, iter_76_21)
			end
		end

		if arg_76_3.pointer_enter_exit and not arg_76_4 then
			for iter_76_22, iter_76_23 in pairs(arg_76_3.pointer_enter_exit) do
				self:__bind_control_pointer_enter_exit(arg_76_1, arg_76_2, iter_76_22, iter_76_23)
			end
		end

		if arg_76_3.click_drag and not arg_76_4 then
			for iter_76_24, iter_76_25 in pairs(arg_76_3.click_drag) do
				self:__bind_control_click_drag(arg_76_1, arg_76_2, iter_76_24, iter_76_25)
			end
		end

		if arg_76_3.dropdown and not arg_76_4 then
			for iter_76_26, iter_76_27 in pairs(arg_76_3.dropdown) do
				self:__bind_control_dropdown(arg_76_1, arg_76_2, iter_76_26, iter_76_27)
			end
		end

		if arg_76_3.trigger_2d and not arg_76_4 then
			for iter_76_28, iter_76_29 in pairs(arg_76_3.trigger_2d) do
				self:__bind_control_trigger_2d(arg_76_1, arg_76_2, iter_76_28, iter_76_29)
			end
		end

		if arg_76_3.ui_scroll_end and not arg_76_4 then
			for iter_76_30, iter_76_31 in pairs(arg_76_3.ui_scroll_end) do
				self:ui_scroll_end(arg_76_1, arg_76_2, iter_76_30, iter_76_31)
			end
		end

		return true
	end

	function arg_3_0:__bind_rule(arg_77_1, arg_77_2, arg_77_3)
		for iter_77_0, iter_77_1 in pairs(arg_77_3.none) do
			local var_77_0 = arg_77_2:Find(iter_77_0)

			if not var_77_0 then
				log.errorlog(var_0_3("%s Find %s failed!", arg_77_1, iter_77_0))

				return false
			end

			for iter_77_2, iter_77_3 in pairs(iter_77_1.set) do
				self._control[iter_77_2] = iter_77_3.tp and var_77_0.gameObject:GetComponent(var_0_10(iter_77_3.tp)) or var_77_0.gameObject
			end
		end

		for iter_77_4, iter_77_5 in pairs(arg_77_3.click) do
			local var_77_1 = arg_77_2:Find(iter_77_4)

			if not var_77_1 then
				log.errorlog(var_0_3("%s Find %s failed!", arg_77_1, iter_77_4))

				return false
			end

			local var_77_2 = var_77_1.gameObject
			local var_77_3 = self:__make_event_func((string.gsub(iter_77_4, "/", "_")))

			arg_77_3.click[iter_77_4] = var_77_3

			self:__add_listener(var_77_2:GetComponent(var_0_10(UnityEngine.UI.Button)), "onClick", var_77_3)
		end

		return true
	end

	function arg_3_0.__make_event_func(arg_78_0, arg_78_1, arg_78_2)
		arg_78_2 = arg_78_2 or "onClick"

		local var_78_0 = var_0_3("__%s_%s", arg_78_2, arg_78_1)

		return function(...)
			if not arg_78_0[var_78_0] then
				var_0_0.error(var_0_3("not find function, name:%s", var_78_0))
			end

			arg_78_0[var_78_0](arg_78_0, ...)
		end
	end

	function arg_3_0:__make_event_func_probably_null(arg_80_1, arg_80_2)
		arg_80_2 = arg_80_2 or "onClick"

		local var_80_0 = self[var_0_3("__%s_%s", arg_80_2, arg_80_1)]

		if not var_80_0 then
			return
		else
			return function(...)
				var_80_0(self, ...)
			end
		end
	end
end)

local function var_0_16(arg_82_0, arg_82_1)
	local var_82_0 = var_0_0.class("ui_base")

	var_82_0._panel = nil
	var_82_0._parent = nil
	var_82_0._ui_name = nil
	var_82_0._ui_panel = nil
	var_82_0._is_visible = false
	var_82_0._control = {}
	var_82_0._peer_list = {}
	var_82_0._listener_list = {}
	var_82_0._do_tween_list = {}
	var_82_0._children = {}
	var_82_0._canvas_set = {}
	var_82_0._loaded_asset_set = {}
	var_82_0._rule_ = {
		none = {},
		click = {}
	}
	var_82_0._mgr_ = arg_82_0
	var_82_0._id_ = arg_82_1

	arg_82_0:__add_object(arg_82_1, var_82_0)

	return var_82_0
end

lx.define_class("UILoader", function(arg_83_0)
	function arg_83_0:reset()
		self:__profile_end((self:__profile_begin("reset begin")))

		self._state_ui_set = {}
		self._ui_name_set = {}
		self._dont_destroy = {}
		self._ui_instance = {}
		self._showing_ui = {}
		self._delay_list = {}

		self:__clear_lru()
		self:__clear_all_object()
		self:__profile_end((self:__profile_begin("reset finish")))
		self:__profile_end((self:__profile_begin("reset")))
	end

	function arg_83_0:checkInit()
		self._lru_capacity = 0

		if app:getSystem():getOSType() == "android" then
			self._lru_capacity = 2
		end

		if self._lru_pool == nil then
			self._lru_pool = {}
			self._lru_num = 0
			self._delay_list = {}
			self._last_time = 0
		end

		if get_system_memory_info then
			local var_85_0, var_85_1 = get_system_memory_info()

			if var_85_0 > 0 and var_85_1 > 0 then
				self._lru_capacity = var_85_0 < 838860.8 and 0 or var_85_0 < 1048576 and 1 or var_85_0 < 1258291.2 and 2 or var_85_0 < 1572864 and 3 or var_85_0 < 2097152 and 4 or var_85_0 < 2516582.4 and 5 or var_85_0 < 3774873.6 and 6 or 8
			end

			if not is_64_bits() and self._lru_capacity > 6 then
				self._lru_capacity = 6
			end
		end

		if not var_0_11:isEnableAssetBundle() then
			self._lru_capacity = 0
		end

		collectgarbage("setpause", 100)
		collectgarbage("setstepmul", 800)
	end

	function arg_83_0.setProfileLogFunc(arg_86_0, arg_86_1)
		arg_86_0._profile_log_func = arg_86_1
	end

	function arg_83_0.enableProfile(arg_87_0, arg_87_1)
		arg_87_0._enable_profile = arg_87_1
	end

	function arg_83_0:setPath(arg_88_1, arg_88_2)
		var_0_2(var_0_1(arg_88_1) == "string" and arg_88_1 ~= "")
		var_0_2(var_0_1(arg_88_2) == "string" and arg_88_2 ~= "")

		self._lua_path = arg_88_1
		self._ui_path = arg_88_2

		self:__check_init()
	end

	function arg_83_0:initAll(arg_89_1, arg_89_2, arg_89_3, arg_89_4, arg_89_5, arg_89_6)
		for iter_89_0, iter_89_1 in pairs(arg_89_1) do
			local var_89_0 = false

			if arg_89_5 then
				var_89_0 = arg_89_5[iter_89_1] ~= nil
			end

			if arg_89_6 and not arg_89_6[iter_89_1] then
				-- block empty
			end

			self:__init_one_ui(iter_89_1, arg_89_4[iter_89_1], arg_89_2, arg_89_3, var_89_0, gameenum.common_type.ui_layer.middle)
		end
	end

	function arg_83_0:initUIExtend(arg_90_1, arg_90_2, arg_90_3, arg_90_4, arg_90_5)
		for iter_90_0, iter_90_1 in pairs(arg_90_2) do
			if arg_90_3[iter_90_1] == nil then
				arg_90_4(self:__get_ui_name(iter_90_1), arg_90_1 .. iter_90_1 .. "_event")
			end
		end

		for iter_90_2, iter_90_3 in pairs(arg_90_5 or {}) do
			for iter_90_4, iter_90_5 in pairs(iter_90_3) do
				arg_90_4(self:__get_ui_name(iter_90_2), arg_90_1 .. iter_90_2 .. iter_90_5)
			end
		end
	end

	function arg_83_0:setStateUISet(arg_91_1, arg_91_2)
		self._state_ui_set[arg_91_1] = self._state_ui_set[arg_91_1] or {}

		for iter_91_0, iter_91_1 in pairs((self:_little_clone(arg_91_2))) do
			var_0_4(self._state_ui_set[arg_91_1], iter_91_1)
		end
	end

	function arg_83_0:destroyStateUISet(arg_92_1)
		if self._state_ui_set[arg_92_1] then
			for iter_92_0, iter_92_1 in pairs(self._state_ui_set[arg_92_1]) do
				self:destroyInstance(iter_92_1)
			end

			local function var_92_0()
				collectgarbage("step", 8)
			end

			for iter_92_2, iter_92_3 in pairs(self._state_ui_set[arg_92_1]) do
				self:__real_destroy_ui_obj_from_lru(iter_92_3, var_92_0)
			end
		end
	end

	function arg_83_0:createInstance(arg_94_1)
		local var_94_0 = self._ui_instance[arg_94_1] or self:__try_get_free_ui_obj_from_lru(arg_94_1)

		var_94_0 = var_94_0 or self:__load_ui(arg_94_1)
		self._ui_instance[arg_94_1] = var_94_0

		return var_94_0
	end

	function arg_83_0:destroyInstance(arg_95_1)
		if not self._ui_instance[arg_95_1] then
			return
		end

		if self._ui_instance[arg_95_1]:isVisible() then
			self._ui_instance[arg_95_1]:setVisible(false)
		end

		if self._dont_destroy[arg_95_1] then
			return
		end

		self._ui_instance[arg_95_1]:__reset__()
		self:__push_free_ui_obj_to_lru(self._ui_instance[arg_95_1])

		self._ui_instance[arg_95_1] = nil
	end

	function arg_83_0:addDontDestroyUI(arg_96_1)
		self._dont_destroy[arg_96_1] = arg_96_1
	end

	function arg_83_0:getInstance(arg_97_1)
		return self._ui_instance[arg_97_1]
	end

	function arg_83_0:getActiveInstance(arg_98_1)
		if self._ui_instance[arg_98_1] and self._ui_instance[arg_98_1]:isVisible() then
			return self._ui_instance[arg_98_1]
		end

		return self._ui_instance[arg_98_1]
	end

	function arg_83_0:getUIRoot()
		return self._root
	end

	function arg_83_0._little_clone(arg_100_0, arg_100_1)
		local var_100_0 = {}

		for iter_100_0, iter_100_1 in pairs(arg_100_1) do
			var_100_0[iter_100_0] = iter_100_1
		end

		return var_100_0
	end

	function arg_83_0:runOnce(arg_101_1)
		for iter_101_0, iter_101_1 in pairs(self._ui_instance) do
			iter_101_1:__update__(arg_101_1)
		end

		while true do
			if not self._delay_list[1] then
				break
			end

			if arg_101_1 < self._delay_list[1].expire_time then
				break
			end

			var_0_5(self._delay_list, 1)

			if self._delay_list[1].o then
				self._delay_list[1].o:destroy()
			end

			if self._delay_list[1].func then
				self._delay_list[1].func()
			end
		end

		if var_0_6 then
			var_0_6.collect()
			var_0_6.step_collect()
		end

		if arg_101_1 < self._last_time + 300 then
			return
		end

		self._last_time = arg_101_1
	end

	function arg_83_0:__load_ui_prefab(arg_102_1)
		local var_102_0 = var_0_16(self, self:__alloc_id())

		if not var_102_0:__load(self._root, arg_102_1, self:__get_ui_path(arg_102_1), var_0_9[self:__get_ui_name(arg_102_1) .. "._rule_"], true) then
			return nil
		end

		return var_102_0
	end

	function arg_83_0:__load_ui(arg_103_1)
		local var_103_0 = var_0_9[self:__get_ui_name(arg_103_1)]:create()

		if not var_103_0:__load(self._root, arg_103_1, self:__get_ui_path(arg_103_1), var_0_9[self:__get_ui_name(arg_103_1) .. "._rule_"]) then
			return nil
		end

		return var_103_0
	end

	function arg_83_0:__profile_begin(arg_104_1)
		if not self._enable_profile then
			return nil
		end

		return {
			profile_begin_time = var_0_7(),
			profile_str = arg_104_1,
			memory = processinfo_get().memory.current,
			lua_memory = collectgarbage("count"),
			cs_memory = math.floor(tonumber(tostring(System.GC.GetTotalMemory(false))) / 1024)
		}
	end

	function arg_83_0:__profile_end(arg_105_1, arg_105_2)
		if not self._enable_profile then
			return
		end

		arg_105_2 = arg_105_2 or 0

		local var_105_0 = var_0_7() - arg_105_1.profile_begin_time

		if var_105_0 < arg_105_2 then
			return
		end

		self._profile_log_func(var_0_3("[UILoader] %s elapsed [%s] ms" .. ", memory (%s), lua memory (%s), cs memory (%s)", arg_105_1.profile_str, var_105_0, tostring(processinfo_get().memory.current - arg_105_1.memory), tostring(collectgarbage("count") - arg_105_1.lua_memory), tostring(math.floor(tonumber(tostring(System.GC.GetTotalMemory(false))) / 1024) - arg_105_1.cs_memory)))
	end

	function arg_83_0:define(arg_106_1, arg_106_2)
		var_0_0.define_class(self:__get_ui_name(arg_106_1), arg_106_2, "ui_base")
	end

	function arg_83_0:class(arg_107_1)
		return var_0_0.class(self:__get_ui_name(arg_107_1), var_0_16(self, self:__alloc_id()))
	end

	function arg_83_0:__init_one_ui(arg_108_1, arg_108_2, arg_108_3, arg_108_4, arg_108_5, arg_108_6)
		self:__make_ui_name(arg_108_1, arg_108_2, arg_108_6)

		if not arg_108_5 then
			arg_108_3(self:__get_ui_name(arg_108_1), self._lua_path .. arg_108_1)
		end

		if arg_108_4 then
			arg_108_3(self:__get_ui_name(arg_108_1) .. "._rule_", self._lua_path .. "generate." .. arg_108_1 .. "_Generate")
		end
	end

	function arg_83_0:__get_layer_state(arg_109_1)
		if not self._ui_name_set[arg_109_1] then
			return 1
		end

		return self._ui_name_set[arg_109_1].layer
	end

	function arg_83_0:__set_layer(arg_110_1, arg_110_2, arg_110_3, arg_110_4)
		if not arg_110_1 then
			self:__remove_from_showing(arg_110_2)

			return
		end

		local var_110_0 = self:__get_layer_state(arg_110_2)

		if arg_110_3 and not arg_110_3:Equals(nil) then
			local var_110_1 = 0

			for iter_110_0, iter_110_1 in pairs(self._showing_ui) do
				if self:__get_layer_state(iter_110_1) == var_110_0 and iter_110_0 ~= arg_110_2 then
					var_110_1 = var_110_1 + 1
				end
			end

			arg_110_3.sortingOrder = var_110_0 + var_110_1

			self:__add_to_showing(arg_110_2, arg_110_2)

			for iter_110_2, iter_110_3 in pairs(arg_110_4) do
				iter_110_3.canvas.canvas.sortingOrder = iter_110_3.diff_order + arg_110_3.sortingOrder
			end
		end
	end

	function arg_83_0:__make_ui_name(arg_111_1, arg_111_2, arg_111_3)
		arg_111_2 = arg_111_2 or self._ui_path .. arg_111_1 .. "/"
		self._ui_name_set[arg_111_1] = {
			name = arg_111_1 .. "_.ui",
			path = arg_111_2 .. arg_111_1 .. ".prefab",
			layer = arg_111_3
		}
	end

	function arg_83_0:__get_ui_name(arg_112_1)
		return self._ui_name_set[arg_112_1] and self._ui_name_set[arg_112_1].name
	end

	function arg_83_0:__get_ui_path(arg_113_1)
		return self._ui_name_set[arg_113_1] and self._ui_name_set[arg_113_1].path
	end

	function arg_83_0:__check_init()
		if self._root then
			return
		end

		local var_114_0 = var_0_11:createGameObject("internal/ui/prefab/UIRoot.prefab")

		UnityEngine.GameObject.DontDestroyOnLoad(var_114_0)

		self._root = var_114_0.transform:Find("ParentRoot").gameObject.transform
	end

	function arg_83_0:__alloc_id()
		self._alloc_id = self._alloc_id + 1

		return self._alloc_id
	end

	function arg_83_0:__add_object(arg_116_1, arg_116_2)
		self._all_set[arg_116_1] = arg_116_2
	end

	function arg_83_0:__remove_object(arg_117_1)
		self._all_set[arg_117_1] = nil
	end

	function arg_83_0:__clear_all_object()
		local var_118_0 = {}

		for iter_118_0, iter_118_1 in pairs(self._all_set) do
			var_0_4(var_118_0, iter_118_1)
		end

		for iter_118_2, iter_118_3 in pairs(var_118_0) do
			iter_118_3:destroy()
		end

		self._all_set = {}
	end

	function arg_83_0:__add_to_showing(arg_119_1, arg_119_2)
		self._showing_ui[arg_119_1] = arg_119_2
	end

	function arg_83_0:__remove_from_showing(arg_120_1)
		self._showing_ui[arg_120_1] = nil
	end

	function arg_83_0:__real_destroy_ui_obj_from_lru(arg_121_1, arg_121_2)
		while true do
			local var_121_0 = self:__try_get_free_ui_obj_from_lru(arg_121_1)

			if not var_121_0 then
				break
			end

			self:__push_to_delay_list(var_121_0, arg_121_2, 0 * 863 + 382)
		end
	end

	function arg_83_0:__try_get_free_ui_obj_from_lru(arg_122_1)
		for iter_122_0, iter_122_1 in pairs(self._lru_pool) do
			if iter_122_1:getUIName() == arg_122_1 then
				var_0_5(self._lru_pool, iter_122_0)

				self._lru_num = self._lru_num - 1

				return iter_122_1
			end
		end

		return nil
	end

	function arg_83_0:__push_free_ui_obj_to_lru(arg_123_1)
		table.insert(self._lru_pool, arg_123_1)

		self._lru_num = self._lru_num + 1

		if self._lru_num > self._lru_capacity then
			local var_123_0 = var_0_5(self._lru_pool, 1)

			if var_123_0 then
				self._lru_num = self._lru_num - 1

				self:__push_to_delay_list(var_123_0)
			end
		end
	end

	function arg_83_0:__push_to_delay_list(arg_124_1, arg_124_2, arg_124_3)
		arg_124_3 = arg_124_3 or 618

		var_0_4(self._delay_list, {
			o = arg_124_1,
			func = arg_124_2,
			expire_time = var_0_8:getTime() + arg_124_3
		})
	end

	function arg_83_0.__clear_lru(arg_125_0)
		arg_125_0._lru_pool = {}
		arg_125_0._lru_num = 0
	end
end)

return function()
	local var_126_0 = var_0_0.class("UILoader")

	var_126_0._lua_path = nil
	var_126_0._ui_path = nil
	var_126_0._profile_log_func = nil
	var_126_0._enable_profile = false
	var_126_0._state_ui_set = {}
	var_126_0._ui_name_set = {}
	var_126_0._dont_destroy = {}
	var_126_0._alloc_id = 0
	var_126_0._all_set = {}
	var_126_0._ui_instance = {}
	var_126_0._showing_ui = {}
	var_126_0._lru_capacity = 0
	var_126_0._lru_pool = {}
	var_126_0._lru_num = 0
	var_126_0._delay_list = {}
	var_126_0._last_time = 0
	var_126_0._root = nil

	return var_126_0
end
