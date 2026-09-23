function SetNum(cur,max)
    CSAPI.SetText(txtNum,LanguageMgr:GetByID(76207) .. cur .. "/" .. max)
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent,b)
end

function SetAlpha(alpha)
    CSAPI.SetGOAlpha(btnEnter,alpha)
end

function OnClickEnter()
    
end

function OnClickDirll()
    
end