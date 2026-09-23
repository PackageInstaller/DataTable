--基地建筑
local modelGO = nil

function SetData(_data)
	data = _data
	buildId = data:GetId()
	index = data:GetBoxIndex()
	AddModel()
	--SetPos()
	SetBox()
	--SetScale()
	InitBuildingUI()
end

function OnDestroy()
	CSAPI.RemoveGO(modelGO)
end

--建筑模型
function AddModel()
	local buildName = data:GetModelName()
	if(modelGO) then
		if(modelGO.name == buildName) then
			return
		end
		CSAPI.RemoveGO(modelGO)
	end
	modelGO = CSAPI.CreateGO("Scenes/Matrix/" .. buildName, 0, - 0.155, 0, box)
end

--todo
function SetPos()
	--pos
	local pos = data:GetBuildingPos()
	CSAPI.SetLocalPos(gameObject, pos[1], 1, pos[3])
	--angle
	local angle = data:GetBuildingCfg().angle or 0
	CSAPI.SetAngle(modelGO, 0, angle, 0)
end

function SetTestPos(pos)
	CSAPI.SetLocalPos(gameObject, pos[1], pos[2], pos[3])
end


function SetBox()
	box.name = index .. ""
	
	local scale = data:GetBuildingCfg().modelScale or 1
	CSAPI.SetScale(box, scale, scale, scale)
end

function SetScale()
	local area = data:GetArea()
	CSAPI.SetScale(node, area[1], 1, area[2])
end

--初始化建筑UI
function InitBuildingUI()
	--EventMgr.Dispatch(EventType.Matrix_BuildingObj_Create, this)
end

function HideObj()
	if(matrixBuildingName) then
		CSAPI.SetGOActive(matrixBuildingName.gameObject, false)
	end
	CSAPI.SetGOActive(gameObject, false)
end

function Remove()
	CSAPI.RemoveGO(matrixBuildingName.gameObject)
	matrixBuildingName = nil
	CSAPI.RemoveGO(gameObject)
end

function GetData()
	return data
end

