local color1,color2 = nil,nil

function Init(lockColorStr,unLockColorStr,lockImgName,unLockImgName)
    color1 = lockColorStr or "ffffff"
    color2 = unLockColorStr or "ffc146"
    lockImgName = lockImgName or "img_17_01"
    unLockImgName = unLockImgName or "img_17_02"
    CSAPI.LoadImg(unlock,"UIs/FightTaskItem/" .. unLockImgName..".png",true,nil,true)
    CSAPI.LoadImg(lock,"UIs/FightTaskItem/" .. lockImgName..".png",true,nil,true)
end

function Refresh(tips, isComplete)
    CSAPI.SetText(text_tips, tips or "");
    CSAPI.SetTextColorByCode(text_tips,isComplete and color2 or color1)
	CSAPI.SetGOActive(unlock, isComplete)
	CSAPI.SetGOActive(lock, not isComplete)
end