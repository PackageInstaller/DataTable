--驻员总览
local itemPath1 = "Matrix/MatrixAllBuildingItemO"
local itemPath2 = "Matrix/MatrixAllBuildingItemT"
local curData = nil

function Awake()
	layout = ComUtil.GetCom(vsv, "UIInfinite")
	layout:Init("UIs/Matrix/MatrixAllBuildingItemT", LayoutCallBack, true)
	UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType, "DTU")
end

function LayoutCallBack(index)
	local lua = layout:GetItemLua(index)
	if(lua) then
		local _data = curDatas[index]
		local elseData = curData:GetID() == _data:GetID()
		lua.SetClickCB(SetClickCB)
		lua.Refresh(_data, elseData)
	end
end


function OnInit()
	UIUtil:AddTop2("MatrixAllBuilding", gameObject, function() view:Close() end, nil, {})
	
	
	eventMgr = ViewEvent.New()
	eventMgr:AddListener(EventType.Matrix_Building_Update, RefreshPanel)
	eventMgr:AddListener(EventType.CRole_Update, RefreshPanel)
end

function OnDestroy()
	eventMgr:ClearListener()
end

function OnOpen()
	InitData()
	RefreshPanel()
end

function InitData()
	curDatas = MatrixMgr:GetBuildingDatasArr(false)
	curData = curDatas[1]
end

function RefreshPanel()
	layout:IEShowList(#curDatas, FirstAnim)
	--SetRoleItems()
	
	--role
	local curRole1, curRole2 = MatrixMgr:GetRoleCnt()
	local str = string.format("<color=#ffc146>%s</color>/%s", curRole1,curRole2)
	CSAPI.SetText(txtRole, str)
	
	--
	--SetPos()
end

--首次调用完毕回调
function FirstAnim()
	if(not isAnimEnd) then
		isAnimEnd = true
		CSAPI.SetGOActive(mask, false)
	end
end

--点击回调
function SetClickCB(_curData)
	curData = _curData
	layout:UpdateList()
	--SetRoleItems()
	
	--SetPos()
end


-- --驻员信息
-- function SetRoleItems()
-- 	matrixRoleItems = matrixRoleItems or {}
-- 	local datas = curData:GetRoleInfos()
-- 	ItemUtil.AddItems(itemPath1, matrixRoleItems, datas, grid, nil, 1, curData, function()
-- 		ItemAnims()
-- 	end)
-- end

-- function ItemAnims()
-- 	if(isFirst) then
-- 		return
-- 	end
-- 	isFirst = 1
-- 	for i, v in ipairs(matrixRoleItems) do
-- 		local delay =(i - 1) * 20
-- 		UIUtil:SetObjFade(v.node, 0, 1, nil, 300, delay)
-- 		local y1 = - i * 20
-- 		UIUtil:SetPObjMove(v.node, 0, 0, y1, 0, 0, 0, nil, 200, delay)
-- 	end
-- end


-- local posImg = {1001, 1002, 1003, 1004, 1005, 1006, 1009}
-- function SetPos()
-- 	LanguageMgr:SetText(txt2, 10057, curData:GetBuildingName())
-- 	for i, v in ipairs(posImg) do
-- 		CSAPI.SetGOActive(this["img" .. v], curData:SetBaseCfg().id == v)
-- 	end
-- end
