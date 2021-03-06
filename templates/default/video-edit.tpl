{include file='header.tpl' no_index='1' p="general"} 
<div id="wrapper">
	<div class="container-fluid">
	  <div class="row-fluid">
		<div class="span12">
		<div id="primary" class="video-edit-tpl">
		
		<h1>{$lang.edit_video}</h1>
		{if empty($success) }
		<a href="{$current_user_data.profile_videos_url}" class="btn btn-small pull-right" rel="tooltip" title="{$lang.return_to_profile}">{$lang.submit_cancel}</a>
		{/if}
		<hr />
		{if $success == 'updated'}
		<div class="alert alert-success">
		{$lang.video_updated|sprintf:$current_user_data.profile_videos_url}
		</div>
		{/if}
		
		{if $success == 'deleted'}
		<div class="alert alert-success">
		{$lang.video_deleted|sprintf:$current_user_data.profile_videos_url}
		</div>
		{/if}
				
		{if count($errors) > 0}
		<div class="alert alert-danger">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<ul class="subtle-list">
			{foreach from=$errors item=v}
				<li>{$v}</li>
			{/foreach}
			</ul>
		</div>
		{/if}
		
		{if $show_form}
			
			<form class="form-horizontal" name="edit-video-form" id="upload-video-form" enctype="multipart/form-data" method="post" action="{$form_action}">
			  <div class="alert hide" id="error-placeholder"></div>

				<div class="row-fluid">
					<div class="span3">
					{if $video_type == 'suggested'}
							{if $video_data.image_url != ''}
								<img src="{$video_data.image_url}?cache-buster={php}echo time();{/php}" width="220" />
							{else}
								<img src="{$smarty.const._NOTHUMB}" width="220" />
							{/if}
					{else if $video_type == 'uploaded'}
							{if $video_data.image_url != ''}
								<img src="{$video_data.image_url}?cache-buster=1234" width="220" />
							{else}
								<img src="{$smarty.const._NOTHUMB}" width="220" />
							{/if}
					{/if}

					{if $video_status == 'pending'} 
					<div class="alert alert-danger">
						{$lang.video_pending_approval}
					</div>
					{/if}
					</div>

					<div class="span9">
					{if $video_type == 'suggested'}						
						<div class="control-group">
						  <label class="control-label" for="direct">{$lang._videourl}</label>
						  <div class="controls">
							<input type="text" class="span8" name="direct" value="{$video_data.direct}" placeholder="http://"> <span class="hide" id="loading-gif-top"><img src="{$smarty.const._URL}/templates/{$template_dir}/img/ajax-loading.gif" width="" height="" alt=""></span>
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="yt_thumb">{$lang.upload_video2}</label>
						  <div class="controls">
							<input type="text" class="span8" name="yt_thumb" value="{$video_data.image_url}" placeholder="http://">
						  </div>
						</div>
					{else if $video_type == 'uploaded'}
						<div class="control-group">
						  <label class="control-label" for="mediafile">{$lang.replace_file}</label>
						  <div class="controls">
							<span class="btn-upload border-radius4" rel="tooltip" title="*.flv,*.mp4,*.wmv,*.mov,*.divx,*.avi,*.mkv, *.asf, *.wma, *.mp3, *.m4v, *.m4a, *.3gp, *.3g2<br /> Maximum: {$upload_limit}"><span id="uploadButtonPlaceholder"></span></span>
							<div>
							<small><div id="uploadProgressBar"></div></small>
							<div id="divStatus"></div>
							<ol id="uploadLog"></ol>
							</div>
							<input type="hidden" name="_pmnonce_t" value="{$upload_csrf_token}" />
							<input type="hidden" name="temp_id" id="temp_id" value="" />
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="capture">{$lang.upload_video2}</label>
						  <div class="controls">
								<input type="file" name="capture" value="" size="40">
								<input type="hidden" name="MAX_FILE_SIZE" value="{$max_file_size}">
								<span class="help-inline"><a href="#" rel="tooltip" title="*.jpg, *.jpeg, *.gif, *.png"><i class="icon-info-sign"></i></a></span>
						  </div>
						</div>
					{/if}

					<hr />
					<div id="upload-video-extra">
						<div class="control-group">
						  <label class="control-label" for="video_title">{$lang.video}</label>
						  <div class="controls">
						  <input name="video_title" type="text" value="{$video_data.video_title}" class="span10">
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="description">{$lang.description}</label>
						  <div class="controls">
							<textarea name="description" class="span10" rows="3">{$video_data.description}</textarea>
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="duration">{$lang._duration}</label>
						  <div class="controls">
						  <input name="duration" id="duration" type="text" value="{$video_data.duration}" class="input-mini" style="text-align: center;">
						  <span class="help-inline"><a href="#" rel="tooltip" title="{$lang.duration_format}"><i class="icon-info-sign"></i></a></span>
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="category">{$lang.category}</label>
						  <div class="controls">
							{$categories_dropdown}
						  </div>
						</div>
						<div class="control-group">
						  <label class="control-label" for="tags">{$lang.tags}</label>
						  <div class="controls">
							<div class="tagsinput">
							  <input id="tags_upload" name="tags" type="text" class="tags" value="{$video_data.tags}"> <span class="help-inline"><a href="#" rel="tooltip" title="{$lang.suggest_ex}"><i class="icon-info-sign"></i></a></span>
							</div>
						  </div>
						</div>
					</div><!-- #upload-video-extra -->
					<div class="">
					  <div class="controls">
						<button class="btn btn-success" name="submit-btn" id="edit-video-submit-btn" value="{$lang.submit_submit}" type="submit">{$lang.save_changes}</button> <span class="hide" id="loading-gif-bottom"><img src="{$smarty.const._URL}/templates/{$template_dir}/img/ajax-loading.gif" width="" height="" alt=""></span>
						{if $allow_user_delete_video}
						<button class="btn btn-danger" name="delete-btn" id="edit-video-delete-btn" value="{$lang.delete}" type="button">{$lang.delete_this_video}</button>
						{/if}
						<input type="hidden" name="form_id" value="{$form_id}" />
						<input type="hidden" name="_pmnonce_t_edit_video_form" value="{$form_csrf._pmnonce_t}" id="_pmnonce_t_edit_video_form{$form_csrf._pmnonce_t}" />
						
						<input type="hidden" name="btn-pressed" value="" />
					  </div>
					</div>
					<div class="alert hide" id="ajax-error-placeholder"></div>
					<div class="alert alert-success hide" id="ajax-success-placeholder"></div>

					</div>
				</div>

			</form>
		{/if}
		</div><!-- #primary -->
	</div><!-- #content -->
  </div><!-- .row-fluid -->
</div><!-- .container-fluid -->     
		
{include file='footer.tpl' tpl_name="video-edit"}