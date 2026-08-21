local WU, DB, REF = require("Common/WindowUtil")(this)

function InitWindow()
  REF.ScrollView.UIScrollView:ResetPosition()
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString("Help_RuleInstruction")
end

function SetLabel(text)
  REF.Label.UIHtmlLabel.text = text
end

function SetTitle(title)
  REF.LabelTitle.UIHtmlLabel.text = title
end

function SetCloseCallBack(call)
  REF.ButtonClose["$SetCallback"](call)
end
