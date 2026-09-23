--建筑 
function OnOpen()
	arr = MatrixMgr:GetBuildingDatasArr()
	if(data) then
		--由基建内部打开
		for i, v in ipairs(arr) do
			if(data:GetID() == v:GetID()) then
				table.remove(arr, i)
				break
			end
		end
		table.insert(arr, {}) --添加宿舍
	end
	items = items or {}
	ItemUtil.AddItems("Dorm/DormBuildingItem", items, arr, grids, ItemClickCB)
end

function ItemClickCB(index)
	local _data = arr[index]
	if(_data.data and _data:GetID()) then
		-- local scene = SceneMgr:GetCurrScene()
		-- if(scene.key == "MatrixBuilding") then
		-- 	EventMgr.Dispatch(EventType.Matrix_Indoor_Change, _data)
		-- 	view:Close()
		-- else	
		-- 	SceneLoader:Load("MatrixBuilding", function()
		-- 		CSAPI.OpenView("MatrixBuilding", _data)
		-- 	end)
		-- end
		--更换场景
		EventMgr.Dispatch(EventType.Matrix_Indoor_Change, {"MatrixBuilding", _data})
	else
		--选择宿舍
		CSAPI.OpenView("DormRoom")
	end
end

function OnClickMask()
	view:Close()
end
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	grids = nil;
	view = nil;
end
----#End#----
