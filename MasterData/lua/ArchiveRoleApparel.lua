local itemScaleX = 116   --item大小
local scaleDown = 0.77   --缩小比例约 0.65
local interval = 21     --间隔
local canUse = false

function Awake()
	--模型
	local goRT = CSAPI.GetGlobalGO("CommonRT")
	CSAPI.SetRenderTexture(goModelRaw, goRT)
	CSAPI.SetCameraRenderTarget(goModelRaw, goRT)
end

function OnEnable()
	ViewModelMgr:SetModelCreater(this)
end

function OnDisable()
	if(not curRoleSkinInfo:CheckCanUse(cRoleData)) then
		curRoleSkinInfo = roleSkinInfos[useIndex]
	end
	SetImg()
end

function OnDestroy()
	ViewModelMgr:RemoveModelCreater(this)
	ReleaseCSComRefs()
end

function SetRoleParent(_cardIconItem)
	cardIconItem = _cardIconItem
end

function Refresh(_data, _curSkinData)
	cRoleData = _data
	curRoleSkinInfo = _curSkinData
	
	InitSkinData()
	
	CSAPI.SetText(txtName1, cRoleData:GetName())
	
	RefreshPanel()
end

function InitSkinData()
	roleSkinInfos = {}
	local _models = cRoleData:GetAllSkins()
	for i, v in pairs(_models) do
		table.insert(roleSkinInfos, v)
	end
	table.sort(roleSkinInfos, function(a, b)
		if(a:GetIndex() == b:GetIndex()) then
			return a:GetSkinID() < b:GetSkinID()
		else
			return a:GetIndex() < b:GetIndex()
		end
	end)
end

function RefreshPanel()
	useIndex = GetBaseIndex()  --当前使用的
	curIndex = curIndex or useIndex        --当前点中的
	SetItems()
	Select()
end

--第几个
function GetBaseIndex()
	local curSkinID = curRoleSkinInfo:GetSkinID()
	for i, v in ipairs(roleSkinInfos) do
		if(v:GetSkinID() == curSkinID) then
			return i
		end
	end
	return 1
end

function SetItems()
	items = items or {}	
	local dataLen = #roleSkinInfos
	for i = dataLen + 1, #items do
		CSAPI.SetGOActive(items[i].gameObject, false)
	end
	local breakLv = cRoleData:GetBreakLevel()
	for i, v in ipairs(roleSkinInfos) do
		local x = GetPos(i)
		if(i <= #items) then
			items[i].Refresh(i, false, i == curIndex, v, breakLv, SelectItemCB)
			CSAPI.SetGOActive(items[i].gameObject, true)
			CSAPI.SetAnchor(items[i].gameObject, x, 0, 0)
		else
			ResUtil:CreateUIGOAsync("CRoleItem/ApparelItem1", Content, function(go)
				local item = ComUtil.GetLuaTable(go)
				item.Refresh(i, false, i == curIndex, v, breakLv, SelectItemCB)
				CSAPI.SetAnchor(go, x, 0, 0)
				table.insert(items, item)
			end)
		end		
	end
end

function GetPos(_index)
	local minScale = itemScaleX * scaleDown
	local posX =(_index - 1) *(interval + minScale)
	if(_index == curIndex) then
		posX = posX + itemScaleX / 2
	elseif(_index > curIndex) then
		posX = posX + minScale / 2 + itemScaleX - minScale
	else
		posX = posX + minScale / 2
	end
	return posX
end

function SelectItemCB(index)
	if(curIndex ~= index) then
		-- items[curIndex].Select(false)
		curIndex = index
		-- items[curIndex].Select(true)
		SetItems()
		Select()
	end
end

--选中
function Select()
	curRoleSkinInfo = roleSkinInfos[curIndex]
	--img
	SetImg()
	--name2
	CSAPI.SetText(txtName2, curRoleSkinInfo:GetName())
	--CSAPI.SetText(txtName3, curRoleSkinInfo:GetEnglishName())
	--图标 todo
	--颜色
	--local s_colors = curRoleSkinInfo:GetCfg().s_colors
	--local colors = StringUtil:split(s_colors, ",")
	--CSAPI.SetImgColorByCode(imgNameColor, colors[1])
	--btn
	SetBtn()
	--design
	--CSAPI.SetText(txtName3, "DESIGN: " .. curRoleSkinInfo:GetCfg().design)
	--model
	FuncUtil:Call(SetModel, nil, 50, curRoleSkinInfo:GetSkinID())
	--SetModel(curRoleSkinInfo:GetSkinID())
end

--立绘
function SetImg()
	cardIconItem.Refresh(cRoleData:GetID(), curRoleSkinInfo:GetSkinID(), LoadImgType.RoleInfo)
end

function SetBtn()
	canUse = true
	if(useIndex == curIndex) then
		canUse = true
	else
		canUse = curRoleSkinInfo:CheckCanUse(cRoleData)
	end
	if(canUse) then
		CSAPI.SetText(txtSure, "")
	else
		local b2 = false
		local str = ""
		--突破解锁
		if(curRoleSkinInfo.type == CardSkinType.Break) then
			str = LanguageMgr:GetByID(29072, curRoleSkinInfo.minBreakLv)
			-- str = string.format("突破%s阶解锁", curRoleSkinInfo.minBreakLv)
		else
			local getCondition = curRoleSkinInfo:GetCfg().getCondition
			if(getCondition and getCondition[1] == 1) then
				--购买解锁
				-- str = StringConstant.archive10
			else
				--其它解锁
			end
		end
		CSAPI.SetText(txtSure, str)
	end
end

-----------------------------------------------------模型
--显示角色模型的必要方法
function ShowModelState(state)
	CSAPI.SetGOActive(goModelRaw, state)
end

--创建模型
function CreateModel(modelId, followTarget)	
	local go = CSAPI.CreateGO("ModelNode", 0, 0, 0, modelNode)
	local lua = ComUtil.GetLuaTable(go)
	lua.Set(followTarget, UIUtil:GetUICameraGO(), modelRoot)
	lua.LoadModel(modelId)
	return lua
end

function SetModel(skinID)
	if luaModel then
		CSAPI.RemoveGO(luaModel.gameObject)
		luaModel = nil
	end
	luaModel = ViewModelMgr:CreateModel(skinID, modelRoot)
	if luaModel then
		CSAPI.SetGOActive(goModelRaw, true)
		local index = transform.parent:GetSiblingIndex() or 0
		SetModelZ(9 - index)
		luaModel.SetModelRotation(0, 90, 0)
		--luaModel.SetBorder(false)
		luaModel.SetLeader(false)
		luaModel.SetBottom(false)
		luaModel.SetShadow(false)
	else
		CSAPI.SetGOActive(goModelRaw, false)
	end
end

function SetModelZ(value)
	if(luaModel) then
		local x, y, z = CSAPI.GetLocalPos(luaModel.gameObject)
		z = value
		CSAPI.SetLocalPos(luaModel.gameObject, x, y, z)
	end
end


----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
left=nil;
txtName1=nil;
txtName2=nil;
modelPoint=nil;
Content=nil;
txtSure=nil;
goModelRaw=nil;
modelRoot=nil;
ModelCamera=nil;
BGCamera=nil;
modelNode=nil;
view=nil;
end
----#End#----