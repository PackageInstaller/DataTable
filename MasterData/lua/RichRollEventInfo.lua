--固定步数选择
--data:gridInfo
function OnOpen()
    Refresh();
end

function Refresh()
    --显示图标、描述、格子名、
    if data then
        ResUtil.RichManIcon:Load(icon,data:GetIcon());
        CSAPI.SetText(txtName,data:GetName());
        CSAPI.SetText(txtDesc,data:GetDesc());
    end
end

function OnClick()
    Close();
end

function Close()
    if view~=nil then
        view:Close();
    end
end

function OnClickAnyway()
    Close();
end