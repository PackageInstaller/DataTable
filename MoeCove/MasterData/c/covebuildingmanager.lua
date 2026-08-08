require "class"

---@class CoveBuildingManager
local CoveBuildingManager = class("CoveBuildingManager")
local CoveRoom = require "CoveRoom"
local CoveStoryLine = require("CoveStoryLine")

function CoveBuildingManager:ctor(...)
	LuaLogger.ds("CoveBuildingManager ctor")
	---@type CoveManager
	self._coveMgr = nil

	self.bulidingBtnCfg = {
		[10003] = {id = 10003, isRes = false, funcType = HomeFuncType.WeaponRoom},
		[10006] = {id = 10006, isRes = false, funcType = HomeFuncType.TrainingRoom},
		[10012] = {id = 10012, isRes = false, funcType = HomeFuncType.ProduceRoom},
		[10009] = {id = 10009, isRes = false, funcType = HomeFuncType.CommandRoom},
		[10010] = {id = 10010, isRes = false, funcType = HomeFuncType.ProduceRoom},
		[10011] = {id = 10011, isRes = false, funcType = HomeFuncType.ProduceRoom},
		[10013] = {id = 10013, isRes = false, funcType = HomeFuncType.ProduceRoom},
		[10018] = {id = 10018, isRes = false, funcType = HomeFuncType.Dorm},
		[10019] = {id = 10019, isRes = false, funcType = HomeFuncType.None, uiName = "CombatIntelligenctPanel"},
		[1001200] = {id = 10012, isRes = true},	
		[1001000] = {id = 10010, isRes = true},
		[1001100] = {id = 10011, isRes = true},
		[1001300] = {id = 10013, isRes = true},
		[10004] = {id = 10004, isRes = false, funcType = HomeFuncType.None, uiName = "HomelandShopPanel"},
	}

	--家园ui层按钮列表
	self.buildingBtnList = {
		-- [int] = {
		-- 	uiObj = UnityEngine.GameObject,	--ui预制
		-- 	staticPos = UnityEngine.Transform.position,--家园位置
		-- 	isRes = bool,	--是否资源类建筑
		-- 	isShow = bool,	--是否显示
		-- }
	}
	local CanvasScaler =  UIMgr.uiCanvas.gameObject:GetComponent("CanvasScaler")
    self.screen_width = CanvasScaler.referenceResolution.x
    self.screen_height = CanvasScaler.referenceResolution.y

	--建筑对应家具obj列表
	self.buildingObjList = {}
	-- {
	-- 	[int] = {	--建筑id
	-- 		[int] = {	--等级
	-- 			UnityEngine.GameObject,
	-- 			...
	-- 		}
	-- 	}
	-- }
	--建筑对应家具管理器列表
	self.buildingMgrList = {}
	-- {
	-- 	[int 建筑id] = {
			-- main = {
			-- 	[int 等级] = CoveBuildingType
			-- },
			-- once = {
			-- 	[int 等级] = CoveBuildingType
			-- }
	-- 		
	-- 	}
	-- }

	---@class BuildMaterial
	---@field main UnityEngine.Material[]
	---@field once UnityEngine.Material[]

	---@class BuildintObjInfo
	---@field id integer
	---@field model UnityEngine.GameObject
	---@field levelModel UnityEngine.GameObject
	---@field lockAtTargetPos UnityEngine.Vector3
	---@field cameraTargetPos UnityEngine.Vector3
	---@field camerDifualDis number
	---@field cameraMoveMaxPos UnityEngine.Vector3
	---@field cameraMoveMinPos UnityEngine.Vector3
	---@field allRenders UnityEngine.Material[]
	---@field allLevelMaterials BuildMaterial[]

	---@type BuildintObjInfo[]
	self.buildintObjInfos = {}

	self.forceCamera = nil
	self.focusingLayer = nil
	self.defaultLayer = 0
	self.focusingBuild = 0
	self.focusingTime = 0
	self.buildingObjCfg = {
		[1] = {
			id = 10003,
			name = "M_WeaponLab",
			modelName = "HL_Factory",
		},
		[2] = {
			id = 10004,
			name = "M_Shop",
			modelName = "WQD",
		},
		[3] = {
			id = 10009,
			name = "SM_Command",
			modelName = "",
		},
		[4] = {
			id = 10006,
			name = "SM_Training",
			modelName = "",
		},
		[5] = {
			id = 10018,
			name = "SuShe",
			modelName = "",
		},
		[6] = {
			id = 10013,
			name = "gangcai",
			modelName = "",
		},
		[7] = {
			id = 10012,
			name = "lvjiagong",
			modelName = "",
		},
		[8] = {
			id = 10011,
			name = "danyaogongchang",
			modelName = "",
		},
		[9] = {
			id = 10015,
			name = "wenquan",
			modelName = "",
		},
		[10] = {
			id = 20001,
			name = "gongchang (1)",
			modelName = "",
		},
		[11] = {
			id = 10005,
			name = "M_Cafe",
			modelName = "",
		},
		[12] = {
			id = 10002,
			name = "SM_Park",
			modelName = "",
		},
		[13] = {
			id = 10010,
			name = "OilPlatform",
			modelName = "",
		},
		[14] = {
			id = GE.CoustructionEnum.MiniGame,
			name = "Game_Console",
			modelName = "",
		},

	}

	self.stateObjInfos = {
		{
			objPaths = {
				{
					"SM_Training/SM_Trainging_ScreenFrame1/Effect_Common_Homeland_SM_Training_Monitor1_b",
					"SM_Training/SM_Trainging_ScreenFrame2/Effect_Common_Homeland_SM_Training_Monitor2_b"
				},
				{
					"SM_Training/SM_Trainging_ScreenFrame1/Effect_Common_Homeland_SM_Training_Monitor1_g",
					"SM_Training/SM_Trainging_ScreenFrame2/Effect_Common_Homeland_SM_Training_Monitor2_g"
				},
			},

			Init = function(self)
				local homelandObj = CoveManager.instance().Homeland
				if homelandObj == nil then
					return
				end
				local parent = homelandObj.transform
				self.stateObjs = {}
				for i = 1, #self.objPaths do
					local paths = self.objPaths[i]
					if paths ~= nil then
						self.stateObjs[i] = {}
						for ii = 1, #paths do
							local trs = parent:Find(paths[ii])
							if not IsNull(trs) then
								table.insert(self.stateObjs[i], trs.gameObject)
							else
								LuaLogger.ws("路径配置错误 物体未找到 path:" .. paths[ii])
							end
						end
					end
				end
			end,


			Update = function(self)
				local state = 1
				if Me:genRoleCanUse() then
					state = 2
				end
				if self.stateObjs == nil then
					return
				end

				for i = 1, #self.stateObjs do
					local isActive = state == i
					local objs = self.stateObjs[i]
					if objs ~= nil then
						for ii = 1, #objs do
							if not IsNull(objs[ii]) then
								objs[ii]:SetActive(isActive)
							end
						end
					end
				end
			end
		}
	}

	self.specialBtnCfg = {
		[GE.CoustructionEnum.MiniGame] = {
			id = GE.CoustructionEnum.MiniGame,
			prefabPath = Config.PrefabPath.CoveSpecialBtn,
			locationObjPath = "Homeland/CanvasNew/Btn%s",
			OnClick = function(self)
				UIMgr:popUI("BombGamePanel")
			end,
			CheckActive = function(self)
				local state, tips, lockShowType, showNew = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.MiniGame)
    			local isUnlock = state ~= GE.FunctionOpenState.Lock
				return isUnlock
			end,
		}
	}

	--是否显示ui按钮
	self.isShowUI = true
	self.scanProgressID = UnityEngine.Shader.PropertyToID("_ScanProgress");
	---@type CoveStoryLine[]?
	self.allCoveStroyLine = nil

	---@class FunctionBuildingObj
	---@field id int
	---@field coveFunctionBuilding CoveFunctionBuilding

	---@type type<int, FunctionBuildingObj>
	self.allFunctionBuilding = nil
end

---设置是否显示按钮ui
---@param bool boolean
function CoveBuildingManager:SetShowBtnUI(bool)
	self.isShowUI = bool
	if not bool then
		for _, v in pairs(self.buildingBtnList) do
			if IsNull(v.uiObj) or v.uiObj.SetActive == nil then
				local a = 0
			end
			v.uiObj:SetActive(bool)
		end
	end

	if bool then
		self.lastUpdateSpecialTime = 0
		self:BuildingLevelChange(GE.CoustructionEnum.Intelligenct)
	end

end

function CoveBuildingManager:FixedUpdate()
	self:UpdateBtnPos()

	self:UpdateBtnSpecialState()

end

--更新UI层按钮位置
function CoveBuildingManager:UpdateBtnPos()
	local camera = CoveManager.instance().camera
	local width = self.screen_width
	local height = self.screen_height

	local sortLayerBtns = {}
	for id, v in pairs(self.buildingBtnList) do
		if v.uiObj then
			--是否隐藏全部ui
			if not self.isShowUI then
				v.uiObj.gameObject:SetActive(false)
				goto continue
			end
			--是否隐藏指定ui
			if not v.isShow then
				v.uiObj.gameObject:SetActive(false)
				goto continue
			end
			--同步位置
			local targetPos = v.staticPos
			local result = camera:WorldToViewportPoint(targetPos)
			if result.x < 0 or result.x > 1 or result.y < 0 or result.y > 1 or result.z < 0 then
				v.uiObj.gameObject:SetActive(false)
			else
				--第一次打开需要同步刷新scale
				local isActive = v.uiObj.gameObject.activeSelf
				if not isActive then
					-- self:RefreshBtnScale(id)
					v.uiObj.gameObject:SetActive(true)
				end
				local finalPos = Vector3.New(result.x * width - width/2, result.y * height - height/2, 0)
				if Vector3.Distance(finalPos, v.uiObj.transform.localPosition) > 0.2 then
					v.uiObj.transform.localPosition = finalPos
				end

				if v.updateLayer then
					v.deep = result.z
					table.insert(sortLayerBtns, v)
				else
					v.deep = nil
				end
			end
		end
		::continue::
	end

	table.sort(sortLayerBtns, function(a, b)
		if a == b then
			return false
		end
		return a.deep > b.deep
	end)

	for i = 1, #sortLayerBtns do
		---@type UnityEngine.GameObject
		local btn = sortLayerBtns[i].uiObj
		btn.transform:SetSiblingIndex(i - 1)
	end


end

---实例化
---@return CoveBuildingManager CoveBuildingManager
function CoveBuildingManager.instance()
	if (CoveBuildingManager._instance == nil) then
		CoveBuildingManager._instance = CoveBuildingManager:new()
	end
	return CoveBuildingManager._instance
end

--初始化
function CoveBuildingManager:init(coveMgr)
	self._coveMgr = coveMgr
	self:parseCfg()
	GameMsgMgr:regEvent(GameMsgType.RoleDisposeChange, self, self.RefreshBuildingDisAll)
	GameMsgMgr:regEvent(GameMsgType.ItemMapNtf, self, self.RefreshBuildingDisAll)
	GameMsgMgr:regEvent(GameMsgType.PveLevelMapUpdate, self, self.RefreshBuildingDisAll)
	GameMsgMgr:regEvent(GameMsgType.BulidingLvChange, self, self.BuildingLevelChange)

	GameMsgMgr:regEvent(GameMsgType.FunctionOpenMapUpdate, self, self.OnFunctionOpenMapUpdate)
end

--刷新根据主相机距离修改按钮大小
---@param id number 按钮id
function CoveBuildingManager:RefreshBtnScale(id)
	-- LuaLogger.ds("CoveBuildingManager:RefreshBtnScale", debug.traceback())
	local mindis = CoveManager.instance()._camZoomMinZ
	local maxdis = CoveManager.instance()._camZoomMaxZ
	local current = CoveManager.instance().cameraViewDistance
	if not current then
		return
	end
	local maxScale = 2	--相机最远时的scale
	local minScale = 1.2--相机最近时的scale
	local scaleIndex = minScale + (current - mindis) / (maxdis - mindis) * (maxScale - minScale)
	for k, v in pairs(self.buildingBtnList) do
		--指定刷新某个按钮
		if id then
			if k == id then
				if v.uiObj then
					v.uiObj.transform:Find("scale").transform.localScale = Vector3.New(scaleIndex, scaleIndex, scaleIndex)
				end
				break
			end
		else
			if v.uiObj then
				v.uiObj.transform:Find("scale").transform.localScale = Vector3.New(scaleIndex, scaleIndex, scaleIndex)
			end
		end
	end
end

--配置解析
function CoveBuildingManager:parseCfg()
	--家园按钮
	for id, cfg in pairs(self.bulidingBtnCfg) do
		--寻找场景中按钮位置
		local path = ""
		local clickStr = ""
		local prefabPath = ""
		if cfg.isRes == true then
			path = "Homeland/CanvasNew/BtnRes"
			clickStr = "onClickResBtn"
			prefabPath = Config.PrefabPath.CoveBtnRes
		else
			path = "Homeland/CanvasNew/Btn"
			clickStr = "onClickBtn"
			prefabPath = Config.PrefabPath.CoveBtn
		end
		local pos = GameObject.Find(path .. cfg.id).gameObject.transform.position
		--动态加载对应按钮
		ResMgr:LoadPrefabAsyncInOwner(prefabPath, function (btn)
			--表配置数据
			local cfgInfo = Config.GetConstructionInfo(id)
			local btn = Instantiate(btn).gameObject
			--转ui层
			local uiroot = UIMgr:GetUIRootParent()
			btn.transform:SetParent(uiroot.transform, false)
			--改名
			btn.name = btn.name .. id
			local key = id
			if not self.buildingBtnList[key] then
				self.buildingBtnList[key] = {}
			end
			self.buildingBtnList[key].uiObj = btn	--ui预制
			self.buildingBtnList[key].staticPos = pos	--家园中3d坐标位置
			self.buildingBtnList[key].isRes = cfg.isRes	--是否资源类建筑
			--资源类建筑根据产出数量决定是否显示
			if cfg.isRes then
				self.buildingBtnList[key].isShow = self:GetOutPutNumByConsId(cfg.id) > 0	
			else
				self.buildingBtnList[key].isShow = true	
			end
			--资源
			if cfg.isRes == true then
				local efficiency = Me:getHomeOutputBaseEfficiency(cfg.id)
				if not efficiency or not efficiency[1] then
					Debugger.LogError("efficiency is nil consId:" .. cfg.id)
					return
				end
				ResMgr:LoadSpriteAsyncInOwner(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..efficiency[1][2]), function (s)
					btn.transform:Find("scale/Icon"):GetComponent(TypeInfo.Image).sprite = s
				end, btn.gameObject)
			else
				--普通建筑
				--图标
				ResMgr:LoadSpriteAsyncInOwner(string.format(Config.SpritePath.coveBtn, cfg.id), function (s)
					btn.transform:Find("scale/unlockType/iconImg"):GetComponent(TypeInfo.Image).sprite = s
				end, btn.gameObject)
				--名称
				local name = cfgInfo.name
				btn.transform:Find("scale/unlockType/nameBg/nameText"):GetComponent(TypeInfo.TextMeshProUGUI).text = name
			end
			local scaleButton = btn:GetComponent(TypeInfo.ScaleButton)
			scaleButton.onClick:RemoveAllListeners()
			scaleButton.onClick:AddListener(function ()
				--商店特殊处理
				if cfg.id == GE.CoustructionEnum.Shop then
					if cfg.uiName == "HomelandShopPanel" then
						local btnSoundPath = string.format(Config.AudioPath.SE, "shop")
						self:play2DSound(btnSoundPath)
						--开放条件拦截
						local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomelandShop)
						if state == GE.FunctionOpenState.Lock then
							UICommonUtils.PopToast(tips)
							return
						end
					else
						self:play2DSound(self.btnSoundPath)
					end
					UIMgr:popUI(cfg.uiName)
				else
					if cfg.isRes then
						self[clickStr .. "Common"](self, cfg)
					else
						self:OnClickBtn(cfg.id)
					end
				end
			end)
			--显示解锁状态
			if not cfg.isRes then
				self.buildBtns = self.buildBtns or {}
				local buildBtn = {
					btn = scaleButton,
					lockType = btn.transform:Find("scale/lockType").gameObject,
					unlockType = btn.transform:Find("scale/unlockType").gameObject,
					isUnlock = false
				}
				local constructData = Me:getConstructionDataById(cfg.id)
				local maxLv = Me:getHomeBuildingMaxLevel(cfg.id)
				local isUnlock = false
				--商店特殊处理 永远显示
				if cfg.id == GE.CoustructionEnum.Shop then
					isUnlock = true

					local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomelandShop)
					if state == GE.FunctionOpenState.Lock then
						isUnlock = false
					end

				else
					isUnlock = (constructData ~= nil and constructData.level > 0) or maxLv == 0
					if cfg.id == GE.CoustructionEnum.Intelligenct then
						isUnlock = (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.CombatIntelligenct)) ~= GE.FunctionOpenState.Lock
					end
				end
				buildBtn.lockType:SetActive(not isUnlock)
				buildBtn.unlockType:SetActive(isUnlock)
				if cfg.id == GE.CoustructionEnum.Intelligenct then
					btn:SetActive(isUnlock)
				end
				buildBtn.isUnlock = isUnlock
				self.buildBtns[key] = buildBtn
			end
		end, CoveManager.instance().Homeland)
	end
	--家园建筑
	for _, cfg in pairs(self.buildingObjCfg) do
		-- self.buildingObjList[cfg.id] = {}
		self.buildingMgrList[cfg.id] = {}
		local obj = GameObject.Find("Homeland/" .. cfg.name)

		---@type BuildintObjInfo
		local buildInfo = {}
		local allMaterials = {}
		if UICommonUtils.Checkobj(obj) then
			---@type BuildMaterial[]
			local allLevelMaterials = {}
			for i = 0, 10, 1 do
				local levelObj = obj.transform:Find("LV"..i)
				local onlyLevelObj = obj.transform:Find("LV"..i .. "_only")
				--isOnly boolean 只存在于该等级的建筑群
				local processFunc = function(obj, isOnly)
					if UICommonUtils.Checkobj(obj) then
						local levelMgr = obj.transform:GetComponent(typeof(CoveBuildingType))
						local depObjs = levelMgr.depObjs
						if isOnly then
							if not self.buildingMgrList[cfg.id].once then
								self.buildingMgrList[cfg.id].once = {}
							end
							self.buildingMgrList[cfg.id].once[i] = levelMgr
						else
							if not self.buildingMgrList[cfg.id].main then
								self.buildingMgrList[cfg.id].main = {}
							end
							self.buildingMgrList[cfg.id].main[i] = levelMgr
						end

						if not allLevelMaterials[i] then
							allLevelMaterials[i] = {
								once = {},
								main = {},
							}
						end
						---@type UnityEngine.Material[]
						local materialTab = isOnly and allLevelMaterials[i].once or allLevelMaterials[i].main 
						--每个等级对应obj列表
						for j = 0, depObjs.Count -1 do
							local depObj = depObjs[j]
							if UICommonUtils.Checkobj(depObj) then
								local renderers = depObj:GetComponentsInChildren(TypeInfo.Renderer)
			
								for _j = 0, renderers.Length - 1 do
									local mats = renderers[_j].materials -- 获取副本数组
									for k = 0, mats.Length - 1 do
										local mat = mats[k]
										if mat:HasProperty(self.scanProgressID) then
											table.insert(materialTab,  mat)
										end
									end
									renderers[_j].materials = mats 
								end
							end
						end


					end
				end
				processFunc(levelObj, false)
				processFunc(onlyLevelObj, true)
			end

			buildInfo.levelModel = obj
			buildInfo.allLevelMaterials = allLevelMaterials
			local cameraTarget = obj.transform:Find("CameraTarget")
			if UICommonUtils.Checkobj(cameraTarget) then	
				buildInfo.cameraTargetPos = Vector3.New(cameraTarget.position.x, cameraTarget.position.y, cameraTarget.position.z)
			end

			local lockAtTarget = obj.transform:Find("LockAtTarget")
			if not IsNull(lockAtTarget) then
				buildInfo.lockAtTargetPos = Vector3.New(lockAtTarget.position.x, lockAtTarget.position.y, lockAtTarget.position.z)
				local scale = lockAtTarget.localScale
				local tarPos = buildInfo.lockAtTargetPos
				buildInfo.cameraMoveMaxPos =  Vector3(scale.x, 0, scale.z) + tarPos
				buildInfo.cameraMoveMinPos =  Vector3(-scale.x, 0, -scale.z) + tarPos
				buildInfo.camerDifualDis = Vector3.Distance(buildInfo.cameraTargetPos, buildInfo.lockAtTargetPos)
			end
		end

		obj = nil
		if not (cfg.modelName == nil or cfg.modelName == "") then
			obj = GameObject.Find("Homeland/" .. cfg.modelName)
			if UICommonUtils.Checkobj(obj) then
				buildInfo.model = obj
				local renderers = obj:GetComponentsInChildren(TypeInfo.Renderer)
				for j = 0, renderers.Length - 1 do
					local mats = renderers[j].materials -- 获取副本数组
					for k = 0, mats.Length - 1 do
						local mat = mats[k]
						if mat:HasProperty(self.scanProgressID) then
							table.insert(allMaterials, mat)
						end
					end
					renderers[j].materials = mats 
				end
			end
		end
		buildInfo.allRenders = allMaterials

		self.buildintObjInfos[cfg.id] = buildInfo
		self:refreshBuildingShow(cfg.id)
	end	
	self.focusingLayer = UnityEngine.LayerMask.NameToLayer("Focusing")

	local canvasPath = "Homeland/CanvasNew"
	local canvas = GameObject.Find(canvasPath).transform
	DUtil.AutoCleanDelegate(canvas.gameObject)
	
	local childCount = canvas.childCount

	local stuff = "NewBtnRes_"

	---@type NewBuildingsResObj[]
	self.generateBuildingsFunBtns = {}
	for i = 0, childCount -1  do
		local child = canvas:GetChild(i)
		if not string.startswith(child.name, stuff) then
			goto continue
		end

		local buildId = string.sub(child.name, string.len(stuff) + 1)
		buildId = tonumber(buildId)

		---@type ScaleButton
		local buildBtn = child:Find("buildBtn"):GetComponent(TypeInfo.ScaleButton)
		---@type ScaleButton
		local levelUpBtn = child:Find("levelUpBtn"):GetComponent(TypeInfo.ScaleButton)


		local getRewardBtnTrs = child:Find("getRewardBtn")
		---@type ScaleButton
		local getRewardBtn = getRewardBtnTrs:GetComponent(TypeInfo.ScaleButton)
		---@type UnityEngine.UI.Image
		local iconImage =  getRewardBtnTrs:Find("iconImage"):GetComponent(TypeInfo.Image)
		---@type UnityEngine.UI.Image
		local progressImg =  getRewardBtnTrs:Find("progressImg"):GetComponent(TypeInfo.Image)
		---@type TMPro.TextMeshProUGUI
		local proText =  getRewardBtnTrs:Find("proText"):GetComponent(TypeInfo.TextMeshProUGUI)

		---@type UnityEngine.Animation
		local getRewardBtnAniam = getRewardBtnTrs:GetComponent(TypeInfo.Animation)
		---@type UnityEngine.CanvasGroup
		local getRewardCanvasGroup = getRewardBtnTrs:GetComponent(TypeInfo.CanvasGroup)

		---@class NewBuildingsResObj
		local tab = {
			buildId = buildId,
			buildBtn = buildBtn,
			levelUpBtn = levelUpBtn,
			getRewardBtn = getRewardBtn,
			iconImage = iconImage,
			progressImg = progressImg,
			proText = proText,
			getRewardBtnAniam = getRewardBtnAniam,
			getRewardCanvasGroup = getRewardCanvasGroup,
			---@type boolean?
			canGet = nil,
			maxLv = 0,

			---@type fun(self:NewBuildingsResObj)
			Update = function(self)
				if buildBtn == nil or IsNull(buildBtn.gameObject) == nil then
					LuaLogger.es(" 更新resBtn Error  buildBtn == nil id:" .. buildId)
					return
				end
				local homeInfo = Me:getConstructionDataById(self.buildId)
				local lv = 0
				if homeInfo ~= nil then
					lv = homeInfo.level
				end
				---@type ConstructionLevelTable
				local cfg = Config.GetConstructionLevelInfoByTypeLevel(buildId, lv + 1)
				local canLevelUp = false
				if cfg ~= nil then
					canLevelUp = Me:canOpenFunctionByCfg(cfg.restrain)
				end

				local canGet = false
				local output = nil
				if homeInfo ~= nil and tablex.size(homeInfo.output) > 0 then
					output = homeInfo.output
				end
				if output ~= nil then
					for k, v in pairs(output) do
						if v.num > 0 then
							canGet = true
						end
					end
				end
				self.canGet = canGet
				if canGet then
					buildBtn.gameObject:SetActive(false)
					levelUpBtn.gameObject:SetActive(false)
					getRewardBtn.gameObject:SetActive(true)
					getRewardCanvasGroup.alpha = 1
					local isFull = true
					local isEmpty = true
					local numVal = 0
					local maxVal = 0
					for k, reward in pairs(output) do
						local itemid = reward.id
						local efficiency = Me:getEfficiencyByIdAndItemId(self.buildId, itemid)
						if not efficiency then
							Debugger.LogError("efficiency is nil consId:" .. self.buildId .. " itemid:" .. itemid)
							return
						end
						numVal = reward.num
						maxVal = efficiency[4]
						if reward.num ~= maxVal then
							isFull = false
						end
						if reward.num > 0 then
							isEmpty = false
						end
					end
					if isEmpty then
						getRewardBtn.gameObject:SetActive(false)
					else
						local animaClip = nil
						if isFull then
							animaClip = "newBtnRes_reward_2"
						else
							animaClip = "newBtnRes_reward_1"
						end
						getRewardBtn.gameObject:SetActive(true)
						local parp = numVal / maxVal
						self.progressImg.fillAmount = parp
						self.proText.text = math.floor(parp * 100) .. "%"
						if animaClip ~= nil then
							self.getRewardBtnAniam:Play(animaClip)
						end
						
					end
				else
					buildBtn.gameObject:SetActive(false)
					levelUpBtn.gameObject:SetActive(false)
					getRewardBtn.gameObject:SetActive(false)
					if true then
						return
					end
					if lv > 0 then
						getRewardBtn.gameObject:SetActive(true)
						getRewardCanvasGroup.alpha = 0.5
						self.getRewardBtnAniam:Play("newBtnRes_reward_1")
					else
						getRewardBtn.gameObject:SetActive(false)
					end

					if not canLevelUp then
						--getRewardBtn.gameObject:SetActive(false)
					end	
				end
			end
		}
		local id = buildId
		tab.maxLv = Me:getHomeBuildingMaxLevel(id)
		local cb = function()
			LuaMain:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
			local constructData = Me:getConstructionDataById(id)
			if not constructData then
				LuaLogger.e("constructData is nil, id:" .. id)
				return
			end
			local temp = {
				constuctId = id,
				homeType = HomeFuncType.None
			}
			--建造界面
			UIMgr:popUI("HomeLvUpPanel", temp)
		end
		buildBtn.onClick:AddListener(cb)
		levelUpBtn.onClick:AddListener(cb)
		getRewardBtn.onClick:AddListener(function()
			if not tab.canGet then
				--cb()
				return
			end
			self:onClickResBtnCommon({id = id})
		end)
		---@type ConstructionLevelTable
		local cfg = Config.GetConstructionLevelInfoByTypeLevel(buildId, 1)
		local itemId = 0
		local e = tablex.findSingle(cfg.effect, function(a)
        	return a ~= nil and a[1] == 1
    	end)
		if e ~= nil then
			itemId = e[2]
		end
		local itemCfg = Config.GetItemInfo(itemId)
		ResMgr:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon),iconImage.gameObject, function (s)
			iconImage.sprite = s
		end)
		self.generateBuildingsFunBtns[buildId] = tab
		::continue::
	end


	self:InitAllCoveStoryLine()
	self:InitFunctionBuilding()
	self:InitStateObjs()
	self:CreateSpecialBtn()
end


function CoveBuildingManager:BuildingLevelChange(id)
	local homeInfo = Me:getConstructionDataById(id)
	if not homeInfo then
		Debugger.LogError("homeInfo is nil id:" .. id)
		return
	end
	local lv = homeInfo.level
	self:refreshBuildingShow(id)

	--临时家具 等级相等才显示
	if self.buildingMgrList[id] ~= nil and self.buildingMgrList[id].once then
		for level, mgr in pairs(self.buildingMgrList[id].once) do
			if level == (lv - 1) then
				mgr:EnableAllObjects()
			end
		end
	end
	local buildBtn = self.buildBtns and self.buildBtns[id] or nil
	if buildBtn ~= nil then
		if id == GE.CoustructionEnum.Intelligenct then
			local isUnlock = (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.CombatIntelligenct)) ~= GE.FunctionOpenState.Lock
			buildBtn.lockType:SetActive(not isUnlock)
			buildBtn.unlockType:SetActive(isUnlock)
		elseif id == GE.CoustructionEnum.Shop then
			local isUnlock = true
			--开放条件拦截
			local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomelandShop)
			if state == GE.FunctionOpenState.Lock then
				isUnlock = false
			end
			buildBtn.lockType:SetActive(not isUnlock)
			buildBtn.unlockType:SetActive(isUnlock)
		else
			buildBtn.lockType:SetActive(lv <= 0)
			buildBtn.unlockType:SetActive(lv > 0)
		end
	end
	self:ShowBuildingLevelUpDissolveEffect(id, lv)
end


--刷新建筑显示
function CoveBuildingManager:refreshBuildingShow(id)
	local homeInfo = Me:getConstructionDataById(id)
	if not homeInfo then
		Debugger.LogError("homeInfo is nil id:" .. id)
		return
	end
	if not self.buildingMgrList[id] then
		return
	end
	local lv = homeInfo.level
	--主要家具 等级满足就显示
	if self.buildingMgrList[id].main then
		for level, mgr in pairs(self.buildingMgrList[id].main) do
			if lv >= level then
				mgr:EnableAllObjects()
			else
				mgr:DisableAllObjects()
			end
		end
	end
	--临时家具 等级相等才显示
	if self.buildingMgrList[id].once then
		for level, mgr in pairs(self.buildingMgrList[id].once) do
			if level == lv then
				mgr:EnableAllObjects()
			else
				mgr:DisableAllObjects()
			end
		end
	end

end

--刷新所有功能建筑表现
function CoveBuildingManager:RefreshBuildingDisAll()
	for _, cfg in pairs(self.bulidingBtnCfg) do
		--if cfg.isRes == true then
			if self["refresh" .. cfg.id] then
				self["refresh" .. cfg.id](self, cfg)
			else
				self:refreshCommon(cfg)
			end
		--end
	end
	if self.generateBuildingsFunBtns == nil then
		return
	end
	for k, v in pairs(self.generateBuildingsFunBtns) do
		v:Update()
	end
end

--检查建筑产出是否可领取
---@param id integer 建筑id
---@return boolean 是否可领取
function CoveBuildingManager:checkOutputCanGet(id)
	local canGet = false
	local homeInfo = Me:getConstructionDataById(id)
	if not homeInfo or not homeInfo.output then
		return canGet
	end
	for k, v in pairs(homeInfo.output) do
		if v.num > 0 and not self:checkLimit(v.id) then
			canGet = true
			break
		end
	end
	return canGet
end

--检查是否到达上限
---@param id integer 道具id
function CoveBuildingManager:checkLimit(id)
	--todo 目前没有上限
	return false
end


---@param id integer
function CoveBuildingManager:OnClickBtn(id)
	self:handelHomeClick(id)
end

function CoveBuildingManager:handelHomeClick(id)
	
	self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
	local constructData = Me:getConstructionDataById(id)
	if not constructData then
		LuaLogger.e("constructData is nil, id:" .. id)
		return
	end
	local btnCfg = self.bulidingBtnCfg[id]
	local temp = {
		constuctId = id,
		homeType = btnCfg and btnCfg.funcType or nil
	}
	--建造界面
	if constructData.level and constructData.level == 0 and id ~= 10019 then
		UIMgr:popUI("HomeLvUpPanel", temp)
	else
		---@type string
		local uiName = btnCfg.uiName
		if string.isNullOrEmpty(uiName) then
			uiName = "HomeFuncPanel"
		end
		if uiName == "CombatIntelligenctPanel" then
			local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.CombatIntelligenct)
			if state == GE.FunctionOpenState.Lock then
				UICommonUtils.PopToast(tips)
				return
			end
		end

		local cfg = Config.GetConstructionInfo(id)
		local focusObjName = cfg.camera[1]
		-- focusObjName = "1"
		local zOffSet = cfg.camera[2]
		local focusObj = GameObject.Find("FocusList/" .. focusObjName).gameObject
		local pos = focusObj.transform.position
		self._coveMgr:LookAtPos(GE.HomeLandPerspectiveType.HomeFunc, pos)
		self._coveMgr.homeFuncVcamObj.transform.localPosition = Vector3.New(0, 0, zOffSet)
		local time = 1
		self._coveMgr:ChangeVCam(self._coveMgr.homeFuncVcamObj, true, true, time)
		self:changeBtnState(false)
		local mainPanel = UIMgr:GetUI("MainPanel")
		if mainPanel then
			mainPanel:HideAll(true, true)
		end

		DLuaTimer:DoAfter(time, function()
			UIMgr:popUI(uiName, temp, function()
				--mainPanel:HideAll(false)
			end)
		end)
	end
end


function CoveBuildingManager:FocusingBuild11(id)

	--建造界面
	local cfg = Config.GetConstructionInfo(id)
	if cfg == nil then
		LuaLogger.es("聚焦建筑错误 未找到建筑id:" .. tostring(id))
		return
	end
	local focusObjName = cfg.camera[1]
	if focusObjName == nil then
		LuaLogger.es("聚焦建筑错误 建筑对应的focusObjName 为空 id:" .. tostring(id))
		return
	end
	local focusObj = GameObject.Find("FocusList/" .. focusObjName)
	if IsNull(focusObj) then
		LuaLogger.es("聚焦建筑错误 建筑对应的focusObjName 未找到id:" .. tostring(id))
		return
	end
	local pos = focusObj.transform.position
	CoveManager.instance():LookAtPos(GE.HomeLandPerspectiveType.Whole, pos, { time = 0.5 })

end

--工作区通用点击逻辑
---@param cb fun(reward:GetBuildingRewardResp)
function CoveBuildingManager:onClickResBtnCommon(cfg, cb)
	local consId = cfg.id
	--领取产出
	if self:checkOutputCanGet(consId) then
		Me:GetBuildingsRewardReq({consId}, function(data)
			if cb ~= nil then
				cb(data)
			else
				Me:ReceiveReward(data.rewardList)
			end
		end)
	else
		UICommonUtils.PopToast("没有可领取的资源")
	end
end


--工作区通用点击逻辑
function CoveBuildingManager:GetAllNewBuildingRes()
	

	local allBuildings = self.generateBuildingsFunBtns
	if allBuildings == nil then
		return
	end
	local ids = {}
	for k, v in pairs(allBuildings) do
		if v.getRewardBtn.gameObject.activeSelf then
			table.insert(ids, v.buildId)
		end
	end
	if #ids == 0 then
		return
	end
	Me:GetBuildingsRewardReq(ids, function(data)
		
		
	end)


end

--根据建筑id获取产出数量
function CoveBuildingManager:GetOutPutNumByConsId(id)
	local homeInfo = Me:getConstructionDataById(id)
	if not homeInfo or not homeInfo.output then
		return 0
	end
	local output = homeInfo.output
	local numVal = 0
	for k, reward in pairs(output) do
		numVal = numVal + reward.num
	end
	return numVal
end

--工作区通用刷新逻辑
function CoveBuildingManager:refreshCommon(cfg)
	local consId = cfg.id
	local homeInfo = Me:getConstructionDataById(consId)
	--建筑入口按钮
	local btn = self.buildingBtnList[consId] and self.buildingBtnList[consId].uiObj or nil
	if btn and UICommonUtils.Checkobj(btn) then
		local redState = RedPointMgr:HomeBulidRedJudge(consId)
		local RedPoint = btn.transform:Find("scale/unlockType/RedPoint")
		if UICommonUtils.Checkobj(RedPoint) then
			RedPoint.gameObject:SetActive(redState)
		end
		RedPoint = btn.transform:Find("scale/lockType/RedPoint")
		if UICommonUtils.Checkobj(RedPoint) then
			RedPoint.gameObject:SetActive(redState)
		end
	end
	--建筑资源领取按钮显示逻辑 key为consId*100是为了区分建筑入口按钮和资源领取按钮
	local targetResTable = self.buildingBtnList[consId * 100]
	btn = targetResTable and targetResTable.uiObj or nil
	if not homeInfo or UICommonUtils.Checkobj(btn) == false then
		return
	end
	local output = {}
	if homeInfo.output then
		output = homeInfo.output
	end
	local isFull = true
	local isEmpty = true
	local numVal = 0
	local maxVal = 0
	for k, reward in pairs(output) do
		local itemid = reward.id
		local efficiency = Me:getEfficiencyByIdAndItemId(consId, itemid)
		if not efficiency then
			Debugger.LogError("efficiency is nil consId:" .. consId .. " itemid:" .. itemid)
			return
		end
		numVal = reward.num
		maxVal = efficiency[4]
		if reward.num ~= maxVal then
			isFull = false
		end
		if reward.num > 0 then
			isEmpty = false
		end
	end
	if isEmpty then
		-- btn:SetActive(false)
		targetResTable.isShow = false
	else
		-- btn:SetActive(true)
		targetResTable.isShow = true
		local max = btn.transform:Find("scale/Max")
		if UICommonUtils.Checkobj(max) then
			max.gameObject:SetActive(isFull)
		end
		local numText = btn.transform:Find("scale/NumText")
		if not isFull then
			local percent = btn.transform:Find("scale/Percent")
			if UICommonUtils.Checkobj(percent) then
				local image = percent:GetComponent(TypeInfo.Image)
				image.fillAmount = numVal / maxVal
			end
			
			if UICommonUtils.Checkobj(numText) then
				-- local text = numText:GetComponent(TypeInfo.TextMeshProUGUI)
				-- text.text = math.floor(numVal / maxVal * 100) .. "%"
				local proxy = numText:GetComponent(TypeInfo.TextMeshProUGUI)
				if proxy then
					proxy.text = math.floor(numVal / maxVal * 100) .. "%"
				end
			end
		else
			if UICommonUtils.Checkobj(numText) then
				local proxy = numText:GetComponent(TypeInfo.TextMeshProUGUI)
				if proxy then
					proxy.text = ""
				end
			end
		end
	end
end

--改变建筑按钮激活状态
---@param state boolean
function CoveBuildingManager:changeBtnState(state)
	--LuaLogger.ds("CoveBuildingManager:changeBtnState state:" .. tostring(state))
	--LuaLogger.ds("CoveBuildingManager:changeBtnState traceBack:", debug.traceback())
	self:SetShowBtnUI(state)
	if state == true then
		self:RefreshBuildingDisAll()
		self:CheckAllCoveStroyLineActive()
		self:CheckAllCoveFunctionBuildingActive()
	end
end


---聚焦显示建筑物
---@param buildType integer 建筑类型
function CoveBuildingManager:FocusingBuild(buildType)
	LuaLogger.ds("FocusingBuild buildType:" .. buildType)
	if self.focusingBuild == buildType then
		return
	end
	if self.forceCamera == nil then
		return
	end

	if self.buildintObjInfos == nil then
		return
	end
	local buildInfo = self.buildintObjInfos[buildType]
	if not buildInfo or buildInfo.cameraTargetPos == nil or buildInfo.lockAtTargetPos == nil then
		return
	end
	if self.focusingBuild ~= 0 then
		self:ClearFocusingBuild(self.focusingBuild)
	end
	self.focusingBuild = buildType
	self.forceCamera.enabled = true
	self.forceCamera.transform.position = buildInfo.cameraTargetPos
	self.forceCamera.transform:LookAt(buildInfo.lockAtTargetPos, Vector3.up)

end


---显示建筑物溶解特效 update
---@param inMaterials UnityEngine.Material[]
---@param outMaterilas UnityEngine.Material[]
---@param beginTime number 开始时间
---@param durationTime number 持续时间
---@param cb function
function CoveBuildingManager:DissolveEffectUpdate_outIn(inMaterials, outMaterilas, beginTime, durationTime, cb)

	local passTime = Time.time - beginTime
	local dur = durationTime / 2 
	local p = passTime / durationTime
	p = math.min(p, 1)
	local isP1 = passTime < dur
	p = (passTime % dur) / dur
	p = math.min(p, 1)

	if isP1 then	--播放消失
		local isStart1 = self.dissolveEffectUpdateData.isStart1
		if not isStart1 then
			for i = 1, #outMaterilas do
				local mat = outMaterilas[i]
				MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", true)
				mat:SetFloat(self.scanProgressID, 0)

			end

			for i = 1, #inMaterials do
				local mat = inMaterials[i]
				MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", true)
				mat:SetFloat(self.scanProgressID, 1)
			end
			self.dissolveEffectUpdateData.isStart1 = true
		end

		for i = 1, #outMaterilas do
			local mat = outMaterilas[i]
			mat:SetFloat(self.scanProgressID, p)
		end
	else

		local isStart2 = self.dissolveEffectUpdateData.isStart2
		if not isStart2 then
			for i = 1, #outMaterilas do
				local mat = outMaterilas[i]
				mat:SetFloat(self.scanProgressID, 1)
				MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", true)
			end

			for i = 1, #inMaterials do
				local mat = inMaterials[i]
				MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", true)
				mat:SetFloat(self.scanProgressID, 1)
			end
			self.dissolveEffectUpdateData.isStart2 = true
		end

		for i = 1, #inMaterials do
			local mat = inMaterials[i]
			mat:SetFloat(self.scanProgressID, 1 - p)
		end
	end
	local p = passTime / durationTime
	p = math.min(p, 1)
	local allFinish = p >= 1
	if allFinish then
		for i = 1, #outMaterilas do
			local mat = outMaterilas[i]
			mat:SetFloat(self.scanProgressID, 0)
			MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", false)
		end

		for i = 1, #inMaterials do
			local mat = inMaterials[i]
			mat:SetFloat(self.scanProgressID, 0)
			MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", false)
		end
		if cb ~= nil then
			cb()
		end
	
		self.dissolveEffectUpdateHandle:Stop()
		self.dissolveEffectUpdateHandle = nil
		self.dissolveEffectUpdateData = nil
	end
end



---显示建筑物溶解特效 update
---@param inMaterials UnityEngine.Material[]
---@param outMaterilas UnityEngine.Material[]
---@param beginTime number 开始时间
---@param durationTime number 持续时间
---@param cb function
function CoveBuildingManager:DissolveEffectUpdate_in(inMaterials, beginTime, durationTime, cb)

	local passTime = Time.time - beginTime
	local dur = durationTime
	local p = passTime / durationTime
	p = math.min(p, 1)



	local isStart2 = self.dissolveEffectUpdateData.isStart2
	if not isStart2 then
		for i = 1, #inMaterials do
			local mat = inMaterials[i]
			MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", true)
			mat:SetFloat(self.scanProgressID, 1)
		end
		self.dissolveEffectUpdateData.isStart2 = true
	end

	for i = 1, #inMaterials do
		local mat = inMaterials[i]
		mat:SetFloat(self.scanProgressID, 1 - p)
	end

	local allFinish = p >= 1
	if allFinish then
		for i = 1, #inMaterials do
			local mat = inMaterials[i]
			mat:SetFloat(self.scanProgressID, 0)
			MaterialUtil.SetMaterialKeyword(mat, "_DISSOLVE_ON", false)
		end
		if cb ~= nil then
			cb()
		end
		self.dissolveEffectUpdateHandle:Stop()
		self.dissolveEffectUpdateHandle = nil
		self.dissolveEffectUpdateData = nil
	end
end


---移除焦距显示建筑物
---@param buildType number 建筑物id
function CoveBuildingManager:ClearFocusingBuild(buildType)
	if self.forceCamera == nil then
		return
	end

	if self.buildintObjInfos == nil then
		return
	end
	local buildInfo = self.buildintObjInfos[buildType]
	if not buildInfo then
		return
	end
	self.focusingBuild = 0
	self.forceCamera.enabled = false
	if buildInfo.model ~= nil then
		self:SetLayerRecursively(buildInfo.model, self.defaultLayer)
	end

	if buildInfo.levelModel ~= nil then
		self:SetLayerRecursively(buildInfo.levelModel, self.defaultLayer)
	end

	if self.dissolveEffectUpdateHandle ~= nil then
		self.dissolveEffectUpdateHandle:Stop()
		self.dissolveEffectUpdateHandle = nil
	end
end


---家园升级显示特效
function CoveBuildingManager:ShowBuildingLevelUpDissolveEffect(buildType, lv)

	if self.buildintObjInfos == nil then
		--GameMsgMgr:sendEvent(GameMsgType.BuildingLevelUpDissolveEffectPlayFinish, buildType)
		return
	end
	---@type BuildintObjInfo
	local buildInfo = self.buildintObjInfos[buildType]
	if not buildInfo then
		--GameMsgMgr:sendEvent(GameMsgType.BuildingLevelUpDissolveEffectPlayFinish, buildType)
		return
	end


	---@type BuildMaterial
	local allMaterials = buildInfo.allLevelMaterials[lv]
	if allMaterials == nil then
		GameMsgMgr:sendEvent(GameMsgType.BuildingLevelUpDissolveEffectPlayFinish, buildType)
		return
	end

	---@type UnityEngine.Material[]
	local inMaterials = {}
	local once = allMaterials.once
	tablex.insertrange(inMaterials, #inMaterials + 1, once)
	local main = allMaterials.main
	tablex.insertrange(inMaterials, #inMaterials + 1, main)


	---@type BuildMaterial
	local allMaterials = buildInfo.allLevelMaterials[lv-1]	
	---@type UnityEngine.Material[]
	local outMaterials = {}
	local once = allMaterials.once
	tablex.insertrange(outMaterials, #outMaterials + 1, once)

	---@type ConstructionLevelTable
	local cfg = Config.GetConstructionLevelInfoByTypeLevel(buildType, lv)
	local time = cfg.playLvUpEffectTime
	self:ShowBuildingLevelUpDissolveEffect_1(inMaterials, outMaterials, time, function()
		GameMsgMgr:sendEvent(GameMsgType.BuildingLevelUpDissolveEffectPlayFinish, buildType)
		self:refreshBuildingShow(buildType)
	end)
end

---@param inMaterials UnityEngine.Material[]
---@param outMaterials UnityEngine.Material[]
---@param time number
---@param cb function
function CoveBuildingManager:ShowBuildingLevelUpDissolveEffect_1(inMaterials, outMaterials, time, cb)
	if self.dissolveEffectUpdateHandle ~= nil then
		self.dissolveEffectUpdateHandle:Stop()
		self.dissolveEffectUpdateHandle = nil
	end
	self.dissolveEffectUpdateData = {}
	local updateHandle = nil
	if #outMaterials == 0 then
		updateHandle = BindCallback(self, self.DissolveEffectUpdate_in, inMaterials, Time.time, time/2, cb)
	else
		updateHandle = BindCallback(self, self.DissolveEffectUpdate_outIn, inMaterials, outMaterials, Time.time, time, cb)
	end
	self.dissolveEffectUpdateHandle = FrameTimer.New(updateHandle, 1, -1)
	updateHandle()
	self.dissolveEffectUpdateHandle:Start()
end




--设置模型所有节点layer信息
function CoveBuildingManager:SetLayerRecursively(obj, layer)
    -- 设置当前对象的Layer
    obj.layer = layer

    -- 遍历所有子对象
    for i = 0, obj.transform.childCount - 1 do
        local child = obj.transform:GetChild(i)
        self:SetLayerRecursively(child.gameObject, layer)  -- 递归调用
    end
end

---移动聚焦摄像机
---@param delta UnityEngine.Vector2 鼠标移动增量
function CoveBuildingManager:MoveFocusingCamera(delta)

	local scrollSpeed = 0.01
	local trs = self.forceCamera.transform
    local pos = trs.position
	local zForward = trs.forward + trs.up
    zForward:Normalize()
	pos = pos - (trs.right * delta.x + zForward * delta.y) * scrollSpeed

	---限制范围
	local buildInfo = self.buildintObjInfos[self.focusingBuild]
	if not buildInfo or buildInfo.cameraTargetPos == nil or buildInfo.lockAtTargetPos == nil then
		return
	end
	local maxDis = buildInfo.cameraMoveMaxPos
	local minPos = buildInfo.cameraMoveMinPos
	local cameraTrs = self.forceCamera.transform
	local curLen = (buildInfo.lockAtTargetPos.y- cameraTrs.position.y) / cameraTrs.forward.y
	maxDis = maxDis - cameraTrs.forward * curLen
	minPos = minPos - cameraTrs.forward * curLen

	pos.x = Mathf.Clamp(pos.x, minPos.x, maxDis.x)
	pos.z = Mathf.Clamp(pos.z, minPos.z, maxDis.z)


    trs.position = pos
end

---获取当前聚焦建筑物锁定位置
---@return Vector3|nil
function CoveBuildingManager:GetFocusingCameraLockPos()
	if self.forceCamera == nil then
		return nil
	end

	local buildInfo = self.buildintObjInfos[self.focusingBuild]
	if buildInfo == nil then
		return nil
	end
	local buildInfo = self.buildintObjInfos[self.focusingBuild]
	local cameraTrs = self.forceCamera.transform
	local curLen = (buildInfo.lockAtTargetPos.y- cameraTrs.position.y) / cameraTrs.forward.y
	local curTargetPos = cameraTrs.position + cameraTrs.forward * curLen;
	return curTargetPos
end



function CoveBuildingManager:clear()
	if self.dissolveEffectUpdateHandle ~= nil then
		UpdateBeat:RemoveListener(self.dissolveEffectUpdateHandle)
		self.dissolveEffectUpdateHandle = nil
	end
	self.buildBtns = nil
	self.generateBuildingsFunBtns = nil

	if self.allCoveStroyLine ~= nil then
		for i = 1, #self.allCoveStroyLine do
			local temp = self.allCoveStroyLine[i]
			temp:Destroy()
		end
		self.allCoveStroyLine = nil
	end
	for k, v in pairs(self.buildingBtnList) do
		if v.uiObj and UICommonUtils.Checkobj(v.uiObj) then
			if v.OnDestroy ~= nil then
				v:OnDestroy()
			end
			GameObject.Destroy(v.uiObj)
		end
	end
	self.lastUpdateSpecialTime = nil
	self.buildingBtnList = {}

	GameMsgMgr:unRegEvent(GameMsgType.RoleDisposeChange, self, self.RefreshBuildingDisAll)
	GameMsgMgr:unRegEvent(GameMsgType.ItemMapNtf, self, self.RefreshBuildingDisAll)
	GameMsgMgr:unRegEvent(GameMsgType.PveLevelMapUpdate, self, self.RefreshBuildingDisAll)
	GameMsgMgr:unRegEvent(GameMsgType.BulidingLvChange, self, self.BuildingLevelChange)
	GameMsgMgr:unRegEvent(GameMsgType.FunctionOpenMapUpdate, self, self.OnFunctionOpenMapUpdate)


end

function CoveBuildingManager:play2DSound(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	local ret = AudioMgr:play2DSound(audioPath, ResMgr:GetResCarrier(), volume, loopTime, callBack, track, fadeTime, fadeEase)
	return ret
end

function CoveBuildingManager:play2DVoice(audioPath, volume, loopTime, callBack, track, fadeTime, fadeEase)
	local ret = AudioMgr:play2DVoice(audioPath, ResMgr:GetResCarrier(), volume, loopTime, callBack, track, fadeTime, fadeEase)
	return ret
end


---初始化所有家园
function CoveBuildingManager:InitAllCoveStoryLine()
	local coveStoryLinePath = "Incove_CoveStoryline"
	local parentObj = GameObject.Find(coveStoryLinePath)
	if IsNull(parentObj) then
		return	
	end
	self.allCoveStroyLine = {}
	local parent = parentObj.transform
	local stuff = "CoveStoryLine_"
	local childCount = parent.childCount
	for i = 0, childCount-1 do
		local child = parent:GetChild(i)
		if not string.startswith(child.name, stuff) then
			goto continue
		end
		local groupStr = string.sub(child.name, string.len(stuff) + 1)

		local group = tonumber(groupStr)

		---@type CoveStoryLine
		local storyLine = CoveStoryLine:new(group)
		storyLine:InitTransform(child.gameObject)
		storyLine:CheckActive()
		table.insert(self.allCoveStroyLine, storyLine)
		::continue::
	end
end


function CoveBuildingManager:CheckAllCoveStroyLineActive()
	if self.allCoveStroyLine == nil then
		return
	end
	for i = 1, #self.allCoveStroyLine do
		local temp = self.allCoveStroyLine[i]
		temp:CheckActive()
	end
end

---初始化功能建筑
function CoveBuildingManager:InitFunctionBuilding()
	local rootPath = "CoveFunctionBuilding"
	local parentObj = GameObject.Find(rootPath)
	if IsNull(parentObj) then
		return
	end
	self.allFunctionBuilding = {}
	local parent = parentObj.transform
	local stuff = "CoveFunctionBuilding_"
	local childCount = parent.childCount
	for i = 0, childCount-1 do
		local child = parent:GetChild(i)
		if not string.startswith(child.name, stuff) then
			goto continue
		end
		local funcId = string.sub(child.name, string.len(stuff) + 1)
		---@type int
		local funcId = tonumber(funcId)
		if funcId == nil then
			goto continue
		end
		---@type CoveFunctionBuilding
		local coveFunctionBuilding = child:GetComponent(TypeInfo.CoveFunctionBuilding)
		if IsNull(coveFunctionBuilding) then
			return
		end
		---@type FunctionBuildingObj
		local data = {
			id = funcId,
			coveFunctionBuilding = coveFunctionBuilding,
		}
		coveFunctionBuilding:AddClickEvent(BindCallback(self, self.OnCoveFunctionBuildingClick, funcId))
		self.allFunctionBuilding[data.id] = data
		::continue::
	end

end


function CoveBuildingManager:CheckAllCoveFunctionBuildingActive()
	if self.allFunctionBuilding == nil then
		return
	end

	for k, v in pairs(self.allFunctionBuilding) do
		local id = v.id
		local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(id)
		local isunlock = state ~= GE.FunctionOpenState.Lock
		v.coveFunctionBuilding:SetUnlock(isunlock)
	end
end

---@param funcId int
function CoveBuildingManager:OnCoveFunctionBuildingClick(funcId)

	local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(funcId)
	local isunlock = state ~= GE.FunctionOpenState.Lock
	if not isunlock then
		UICommonUtils.PopToast(tips)
		return
	end

	if funcId == GE.FunctionOpenModule.WeatherForecastPanel then
		UIMgr:popUICover("WeatherForecastPanel")
	end
end


function CoveBuildingManager:UpdateBtnSpecialState()
	if not self.isShowUI then
		return
	end
	if self.lastUpdateSpecialTime ~= nil and (Time.time - self.lastUpdateSpecialTime) < 10 then
		return
	end
	self.lastUpdateSpecialTime = Time.time
	self:UpdateBtn_10019SpecialState()
	self:UpdateStateObjs()
end



function CoveBuildingManager:UpdateBtn_10019SpecialState()
	if self.buildingBtnList == nil then
		return
	end
	local btn = self.buildingBtnList[GE.CoustructionEnum.Intelligenct]
	if btn == nil then
		return
	end
	if IsNull(btn.uiObj) then
		return
	end

	local b = self.buildBtns[GE.CoustructionEnum.Intelligenct]
	if b ~= nil and b.isUnlock == false then
		return
	end

	if btn.special_10019 == nil then
		btn.special_10019 = {}
		btn.special_10019.iconImg = btn.uiObj.transform:Find("scale/unlockType/iconImg").gameObject
		btn.special_10019.effectName = nil
		btn.special_10019.effectPrefab = nil
	end

	---@class special_10019
	---@field iconImg UnityEngine.GameObject
	---@field effectName string
	---@field effectPrefab UnityEngine.GameObject

	---@type special_10019
	local specialData = btn.special_10019
	local num = Me:GetIntelligenctInfoCount()

	local index = 0
	local sortType = {3, 1, 2}
	for i = 1, #sortType do
		local n = num[sortType[i]]
		if n ~= nil and n > 0 then
			index = sortType[i]
			break
		end
	end
	if index == 0 then
		specialData.iconImg:SetActive(true)
		if not IsNull(specialData.effectPrefab) then
			specialData.effectPrefab:SetActive(false)
		end
		return
	end

	specialData.iconImg:SetActive(false)
	local path = Config.PrefabPath["QinBaoBtnEffect_" .. index]
	if path == nil then
		return
	end
	if path == specialData.effectName then
		if not IsNull(specialData.effectPrefab) then
			specialData.effectPrefab:SetActive(true)
		end
	else
		specialData.effectName = path
		ResMgr:LoadPrefabAsyncInOwner(path, BindCallback(self, self.OnLoad10019SpecialEffectCallBack, path), CoveManager.instance().Homeland)
	end
end

---@param path string
---@param effectObj UnityEngine.GameObject
function CoveBuildingManager:OnLoad10019SpecialEffectCallBack(path, effectObj)
	if self.buildingBtnList == nil then
		return
	end
	local btn = self.buildingBtnList[GE.CoustructionEnum.Intelligenct]
	if btn == nil then
		return
	end

	if IsNull(btn.uiObj) then
		return
	end

	if btn.special_10019 == nil then
		return
	end

	---@type special_10019
	local specialData = btn.special_10019
	if specialData.effectName ~= path then
		return
	end
	local eObj = Instantiate(effectObj).gameObject
	if specialData.effectPrefab ~= nil then
		local temp = specialData.effectPrefab
		specialData.effectPrefab = nil
		GameObject.Destroy(temp)
	end
	local parent = specialData.iconImg.transform.parent
	eObj.transform:SetParent(parent)
	eObj.transform.localPosition = Vector3.zero
	eObj.transform.localScale = Vector3.one
	specialData.effectPrefab = eObj
end

function CoveBuildingManager:InitStateObjs()
	if self.stateObjInfos == nil then
		return
	end
	for i = 1, #self.stateObjInfos do
		local info = self.stateObjInfos[i]
		info:Init()
	end
end

function CoveBuildingManager:UpdateStateObjs()
	if not self.isShowUI then
		return
	end
	if self.stateObjInfos == nil then
		return
	end
	for i = 1, #self.stateObjInfos do
		local info = self.stateObjInfos[i]
		info:Update()
	end
end

function CoveBuildingManager:OnFunctionOpenMapUpdate()
	if self.buildBtns == nil then
		return
	end
	local buildBtn = self.buildBtns[GE.CoustructionEnum.Intelligenct]
	if buildBtn ~= nil then
		local isUnlock = (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.CombatIntelligenct)) ~= GE.FunctionOpenState.Lock
		buildBtn.lockType:SetActive(not isUnlock)
		buildBtn.unlockType:SetActive(isUnlock)
	end

	local buildBtn = self.buildBtns[GE.CoustructionEnum.Shop]
	if buildBtn ~= nil then
		local isUnlock = (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.HomelandShop)) ~= GE.FunctionOpenState.Lock
		buildBtn.lockType:SetActive(not isUnlock)
		buildBtn.unlockType:SetActive(isUnlock)
	end
end


function CoveBuildingManager:CreateSpecialBtn()
	local cfgs = self.specialBtnCfg
	if cfgs == nil then
		return
	end
	self.specialBtns = {}
	for k, v in pairs(cfgs) do
		local cfg = v
		local path = string.format(cfg.locationObjPath, cfg.id)
		local pos = GameObject.Find(path).gameObject.transform.position
		local prefabPath = string.format(cfg.prefabPath, cfg.id)
		local id = cfg.id
		--动态加载对应按钮
		ResMgr:LoadPrefabAsyncInOwner(prefabPath, function (btn)
			local btn = Instantiate(btn).gameObject
			--转ui层
			local uiroot = UIMgr:GetUIRootParent()
			btn.transform:SetParent(uiroot.transform, false)
			--改名
			btn.name = "CoveSpecialBtn_" .. id
			local key = id
			if not self.buildingBtnList[key] then
				self.buildingBtnList[key] = {}
			end
			self.buildingBtnList[key].uiObj = btn	--ui预制
			self.buildingBtnList[key].staticPos = pos	--家园中3d坐标位置
			self.buildingBtnList[key].isRes = cfg.isRes	--是否资源类建筑
			--资源类建筑根据产出数量决定是否显示
			local isShow = cfg:CheckActive()
			self.buildingBtnList[key].isShow = isShow

			local scaleButton = btn:GetComponent(TypeInfo.ScaleButton)
			scaleButton.onClick:RemoveAllListeners()
			scaleButton.onClick:AddListener(function ()
				cfg:OnClick()
			end)


			local buildBtn = {
				btn = scaleButton,
				cfg = cfg,
			}
			self.specialBtns[key] = buildBtn

		end, CoveManager.instance().Homeland)
	end
end

function CoveBuildingManager:CheckFunctionOpen()
	if self.specialBtns == nil then
		return
	end
	for k, v in pairs(self.specialBtns) do
		local cfg = v.cfg
		local isShow = cfg:CheckActive()
		local buildBtn = self.buildingBtnList[k]
		if buildBtn ~= nil then
			buildBtn.isShow = isShow
		end
	end
end



return CoveBuildingManager