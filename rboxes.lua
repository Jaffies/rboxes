local rBoxes = {}

do
	local mat = Material('rboxes/simple')
	local mat2 = Material('rboxes/mask')

	local setInt = mat.SetInt

	setInt(mat, '$c0_x', ScrW())
	setInt(mat, '$c0_y', ScrH())

	hook.Add('OnScreenSizeChanged', 'rboxes.screenSizeChanged' .. SysTime(), function(_, _, newW, newH)
		setInt(mat, '$c0_x', newW)
		setInt(mat, '$c0_y', newH)

		setInt(mat2, '$c0_x', newW)
		setInt(mat2, '$c0_y', newH)
	end)

	local setDrawColor = surface.SetDrawColor
	local setMaterial = surface.SetMaterial
	local drawTexturedRect = surface.DrawTexturedRect

	---@param radius number
  ---@param x integer
  ---@param y integer
  ---@param w integer
  ---@param h integer
  ---@param color Color
	function rBoxes.drawRoundedBox(radius, x, y, w, h, color)
		setInt(mat, '$c0_z', radius / w)
		setInt(mat, '$c0_w', radius / h)

		setDrawColor(color)
		setMaterial(mat)

		drawTexturedRect(x, y, w, h)
	end

	local setTexture = mat.SetTexture

	---@param radius number
  ---@param x integer
  ---@param y integer
  ---@param w integer
  ---@param h integer
  ---@param color Color
  ---@param texture ITexture
	function rBoxes.drawRoundedBoxTextured(radius, x, y, w, h, color, texture)
		setInt(mat2, '$c0_z', radius / w)
		setInt(mat2, '$c0_w', radius / h)
		setTexture(mat2, '$basetexture', texture)

		setDrawColor(color)
		setMaterial(mat2)

		drawTexturedRect(x, y, w, h)
	end
end

return rBoxes
