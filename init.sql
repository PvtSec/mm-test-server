--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: channel_type; Type: TYPE; Schema: public; Owner: mmuser
--

CREATE TYPE public.channel_type AS ENUM (
    'P',
    'G',
    'O',
    'D'
);


ALTER TYPE public.channel_type OWNER TO mmuser;

--
-- Name: outgoingoauthconnections_granttype; Type: TYPE; Schema: public; Owner: mmuser
--

CREATE TYPE public.outgoingoauthconnections_granttype AS ENUM (
    'client_credentials',
    'password'
);


ALTER TYPE public.outgoingoauthconnections_granttype OWNER TO mmuser;

--
-- Name: team_type; Type: TYPE; Schema: public; Owner: mmuser
--

CREATE TYPE public.team_type AS ENUM (
    'I',
    'O'
);


ALTER TYPE public.team_type OWNER TO mmuser;

--
-- Name: upload_session_type; Type: TYPE; Schema: public; Owner: mmuser
--

CREATE TYPE public.upload_session_type AS ENUM (
    'attachment',
    'import'
);


ALTER TYPE public.upload_session_type OWNER TO mmuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audits; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.audits (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    action character varying(512),
    extrainfo character varying(1024),
    ipaddress character varying(64),
    sessionid character varying(26)
);


ALTER TABLE public.audits OWNER TO mmuser;

--
-- Name: bots; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.bots (
    userid character varying(26) NOT NULL,
    description character varying(1024),
    ownerid character varying(190),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    lasticonupdate bigint
);


ALTER TABLE public.bots OWNER TO mmuser;

--
-- Name: channelmemberhistory; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.channelmemberhistory (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    jointime bigint NOT NULL,
    leavetime bigint
);


ALTER TABLE public.channelmemberhistory OWNER TO mmuser;

--
-- Name: channelmembers; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.channelmembers (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    roles character varying(256),
    lastviewedat bigint,
    msgcount bigint,
    mentioncount bigint,
    notifyprops jsonb,
    lastupdateat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean,
    mentioncountroot bigint,
    msgcountroot bigint,
    urgentmentioncount bigint
);


ALTER TABLE public.channelmembers OWNER TO mmuser;

--
-- Name: channels; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.channels (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    teamid character varying(26),
    type public.channel_type,
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250),
    lastpostat bigint,
    totalmsgcount bigint,
    extraupdateat bigint,
    creatorid character varying(26),
    schemeid character varying(26),
    groupconstrained boolean,
    shared boolean,
    totalmsgcountroot bigint,
    lastrootpostat bigint DEFAULT '0'::bigint
);


ALTER TABLE public.channels OWNER TO mmuser;

--
-- Name: clusterdiscovery; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.clusterdiscovery (
    id character varying(26) NOT NULL,
    type character varying(64),
    clustername character varying(64),
    hostname character varying(512),
    gossipport integer,
    port integer,
    createat bigint,
    lastpingat bigint
);


ALTER TABLE public.clusterdiscovery OWNER TO mmuser;

--
-- Name: commands; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.commands (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    teamid character varying(26),
    trigger character varying(128),
    method character varying(1),
    username character varying(64),
    iconurl character varying(1024),
    autocomplete boolean,
    autocompletedesc character varying(1024),
    autocompletehint character varying(1024),
    displayname character varying(64),
    description character varying(128),
    url character varying(1024),
    pluginid character varying(190)
);


ALTER TABLE public.commands OWNER TO mmuser;

--
-- Name: commandwebhooks; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.commandwebhooks (
    id character varying(26) NOT NULL,
    createat bigint,
    commandid character varying(26),
    userid character varying(26),
    channelid character varying(26),
    rootid character varying(26),
    usecount integer
);


ALTER TABLE public.commandwebhooks OWNER TO mmuser;

--
-- Name: compliances; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.compliances (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    status character varying(64),
    count integer,
    "desc" character varying(512),
    type character varying(64),
    startat bigint,
    endat bigint,
    keywords character varying(512),
    emails character varying(1024)
);


ALTER TABLE public.compliances OWNER TO mmuser;

--
-- Name: db_lock; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.db_lock (
    id character varying(64) NOT NULL,
    expireat bigint
);


ALTER TABLE public.db_lock OWNER TO mmuser;

--
-- Name: db_migrations; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.db_migrations (
    version bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.db_migrations OWNER TO mmuser;

--
-- Name: desktoptokens; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.desktoptokens (
    token character varying(64) NOT NULL,
    createat bigint NOT NULL,
    userid character varying(26) NOT NULL
);


ALTER TABLE public.desktoptokens OWNER TO mmuser;

--
-- Name: drafts; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.drafts (
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    rootid character varying(26) DEFAULT ''::character varying NOT NULL,
    message character varying(65535),
    props character varying(8000),
    fileids character varying(300),
    priority text
);


ALTER TABLE public.drafts OWNER TO mmuser;

--
-- Name: emoji; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.emoji (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    name character varying(64)
);


ALTER TABLE public.emoji OWNER TO mmuser;

--
-- Name: fileinfo; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.fileinfo (
    id character varying(26) NOT NULL,
    creatorid character varying(26),
    postid character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    path character varying(512),
    thumbnailpath character varying(512),
    previewpath character varying(512),
    name character varying(256),
    extension character varying(64),
    size bigint,
    mimetype character varying(256),
    width integer,
    height integer,
    haspreviewimage boolean,
    minipreview bytea,
    content text,
    remoteid character varying(26),
    archived boolean DEFAULT false NOT NULL,
    channelid character varying(26)
)
WITH (autovacuum_vacuum_scale_factor='0.1', autovacuum_analyze_scale_factor='0.05');


ALTER TABLE public.fileinfo OWNER TO mmuser;

--
-- Name: groupchannels; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.groupchannels (
    groupid character varying(26) NOT NULL,
    autoadd boolean,
    schemeadmin boolean,
    createat bigint,
    deleteat bigint,
    updateat bigint,
    channelid character varying(26) NOT NULL
);


ALTER TABLE public.groupchannels OWNER TO mmuser;

--
-- Name: groupmembers; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.groupmembers (
    groupid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    createat bigint,
    deleteat bigint
);


ALTER TABLE public.groupmembers OWNER TO mmuser;

--
-- Name: groupteams; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.groupteams (
    groupid character varying(26) NOT NULL,
    autoadd boolean,
    schemeadmin boolean,
    createat bigint,
    deleteat bigint,
    updateat bigint,
    teamid character varying(26) NOT NULL
);


ALTER TABLE public.groupteams OWNER TO mmuser;

--
-- Name: incomingwebhooks; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.incomingwebhooks (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26),
    channelid character varying(26),
    teamid character varying(26),
    displayname character varying(64),
    description character varying(500),
    username character varying(255),
    iconurl character varying(1024),
    channellocked boolean
);


ALTER TABLE public.incomingwebhooks OWNER TO mmuser;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.jobs (
    id character varying(26) NOT NULL,
    type character varying(32),
    priority bigint,
    createat bigint,
    startat bigint,
    lastactivityat bigint,
    status character varying(32),
    progress bigint,
    data jsonb
);


ALTER TABLE public.jobs OWNER TO mmuser;

--
-- Name: licenses; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.licenses (
    id character varying(26) NOT NULL,
    createat bigint,
    bytes character varying(10000)
);


ALTER TABLE public.licenses OWNER TO mmuser;

--
-- Name: linkmetadata; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.linkmetadata (
    hash bigint NOT NULL,
    url character varying(2048),
    "timestamp" bigint,
    type character varying(16),
    data jsonb
);


ALTER TABLE public.linkmetadata OWNER TO mmuser;

--
-- Name: notifyadmin; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.notifyadmin (
    userid character varying(26) NOT NULL,
    createat bigint,
    requiredplan character varying(100) NOT NULL,
    requiredfeature character varying(255) NOT NULL,
    trial boolean NOT NULL,
    sentat bigint
);


ALTER TABLE public.notifyadmin OWNER TO mmuser;

--
-- Name: oauthaccessdata; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.oauthaccessdata (
    token character varying(26) NOT NULL,
    refreshtoken character varying(26),
    redirecturi character varying(256),
    clientid character varying(26),
    userid character varying(26),
    expiresat bigint,
    scope character varying(128)
);


ALTER TABLE public.oauthaccessdata OWNER TO mmuser;

--
-- Name: oauthapps; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.oauthapps (
    id character varying(26) NOT NULL,
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    clientsecret character varying(128),
    name character varying(64),
    description character varying(512),
    callbackurls character varying(1024),
    homepage character varying(256),
    istrusted boolean,
    iconurl character varying(512),
    mattermostappid character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.oauthapps OWNER TO mmuser;

--
-- Name: oauthauthdata; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.oauthauthdata (
    clientid character varying(26),
    userid character varying(26),
    code character varying(128) NOT NULL,
    expiresin integer,
    createat bigint,
    redirecturi character varying(256),
    state character varying(1024),
    scope character varying(128)
);


ALTER TABLE public.oauthauthdata OWNER TO mmuser;

--
-- Name: outgoingoauthconnections; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.outgoingoauthconnections (
    id character varying(26) NOT NULL,
    name character varying(64),
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    clientid character varying(255),
    clientsecret character varying(255),
    credentialsusername character varying(255),
    credentialspassword character varying(255),
    oauthtokenurl text,
    granttype public.outgoingoauthconnections_granttype DEFAULT 'client_credentials'::public.outgoingoauthconnections_granttype,
    audiences character varying(1024)
);


ALTER TABLE public.outgoingoauthconnections OWNER TO mmuser;

--
-- Name: outgoingwebhooks; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.outgoingwebhooks (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    creatorid character varying(26),
    channelid character varying(26),
    teamid character varying(26),
    triggerwords character varying(1024),
    callbackurls character varying(1024),
    displayname character varying(64),
    contenttype character varying(128),
    triggerwhen integer,
    username character varying(64),
    iconurl character varying(1024),
    description character varying(500)
);


ALTER TABLE public.outgoingwebhooks OWNER TO mmuser;

--
-- Name: persistentnotifications; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.persistentnotifications (
    postid character varying(26) NOT NULL,
    createat bigint,
    lastsentat bigint,
    deleteat bigint,
    sentcount smallint
);


ALTER TABLE public.persistentnotifications OWNER TO mmuser;

--
-- Name: pluginkeyvaluestore; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.pluginkeyvaluestore (
    pluginid character varying(190) NOT NULL,
    pkey character varying(150) NOT NULL,
    pvalue bytea,
    expireat bigint
);


ALTER TABLE public.pluginkeyvaluestore OWNER TO mmuser;

--
-- Name: postacknowledgements; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.postacknowledgements (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    acknowledgedat bigint
);


ALTER TABLE public.postacknowledgements OWNER TO mmuser;

--
-- Name: postreminders; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.postreminders (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    targettime bigint
);


ALTER TABLE public.postreminders OWNER TO mmuser;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.posts (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    userid character varying(26),
    channelid character varying(26),
    rootid character varying(26),
    originalid character varying(26),
    message character varying(65535),
    type character varying(26),
    props jsonb,
    hashtags character varying(1000),
    filenames character varying(4000),
    fileids character varying(300),
    hasreactions boolean,
    editat bigint,
    ispinned boolean,
    remoteid character varying(26)
)
WITH (autovacuum_vacuum_scale_factor='0.1', autovacuum_analyze_scale_factor='0.05');


ALTER TABLE public.posts OWNER TO mmuser;

--
-- Name: postspriority; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.postspriority (
    postid character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    priority character varying(32) NOT NULL,
    requestedack boolean,
    persistentnotifications boolean
);


ALTER TABLE public.postspriority OWNER TO mmuser;

--
-- Name: poststats; Type: MATERIALIZED VIEW; Schema: public; Owner: mmuser
--

CREATE MATERIALIZED VIEW public.poststats AS
 SELECT userid,
    (to_timestamp(((createat / 1000))::double precision))::date AS day,
    count(*) AS numposts,
    max(createat) AS lastpostdate
   FROM public.posts
  GROUP BY userid, ((to_timestamp(((createat / 1000))::double precision))::date)
  WITH NO DATA;


ALTER MATERIALIZED VIEW public.poststats OWNER TO mmuser;

--
-- Name: preferences; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.preferences (
    userid character varying(26) NOT NULL,
    category character varying(32) NOT NULL,
    name character varying(32) NOT NULL,
    value character varying(2000)
)
WITH (autovacuum_vacuum_scale_factor='0.1', autovacuum_analyze_scale_factor='0.05');


ALTER TABLE public.preferences OWNER TO mmuser;

--
-- Name: productnoticeviewstate; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.productnoticeviewstate (
    userid character varying(26) NOT NULL,
    noticeid character varying(26) NOT NULL,
    viewed integer,
    "timestamp" bigint
);


ALTER TABLE public.productnoticeviewstate OWNER TO mmuser;

--
-- Name: publicchannels; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.publicchannels (
    id character varying(26) NOT NULL,
    deleteat bigint,
    teamid character varying(26),
    displayname character varying(64),
    name character varying(64),
    header character varying(1024),
    purpose character varying(250)
);


ALTER TABLE public.publicchannels OWNER TO mmuser;

--
-- Name: reactions; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.reactions (
    userid character varying(26) NOT NULL,
    postid character varying(26) NOT NULL,
    emojiname character varying(64) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    remoteid character varying(26),
    channelid character varying(26) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.reactions OWNER TO mmuser;

--
-- Name: recentsearches; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.recentsearches (
    userid character(26) NOT NULL,
    searchpointer integer NOT NULL,
    query jsonb,
    createat bigint NOT NULL
);


ALTER TABLE public.recentsearches OWNER TO mmuser;

--
-- Name: remoteclusters; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.remoteclusters (
    remoteid character varying(26) NOT NULL,
    remoteteamid character varying(26),
    name character varying(64) NOT NULL,
    displayname character varying(64),
    siteurl character varying(512),
    createat bigint,
    lastpingat bigint,
    token character varying(26),
    remotetoken character varying(26),
    topics character varying(512),
    creatorid character varying(26),
    pluginid character varying(190) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.remoteclusters OWNER TO mmuser;

--
-- Name: retentionidsfordeletion; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.retentionidsfordeletion (
    id character varying(26) NOT NULL,
    tablename character varying(64),
    ids character varying(26)[]
);


ALTER TABLE public.retentionidsfordeletion OWNER TO mmuser;

--
-- Name: retentionpolicies; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.retentionpolicies (
    id character varying(26) NOT NULL,
    displayname character varying(64),
    postduration bigint
);


ALTER TABLE public.retentionpolicies OWNER TO mmuser;

--
-- Name: retentionpolicieschannels; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.retentionpolicieschannels (
    policyid character varying(26),
    channelid character varying(26) NOT NULL
);


ALTER TABLE public.retentionpolicieschannels OWNER TO mmuser;

--
-- Name: retentionpoliciesteams; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.retentionpoliciesteams (
    policyid character varying(26),
    teamid character varying(26) NOT NULL
);


ALTER TABLE public.retentionpoliciesteams OWNER TO mmuser;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.roles (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    permissions text,
    schememanaged boolean,
    builtin boolean
);


ALTER TABLE public.roles OWNER TO mmuser;

--
-- Name: schemes; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.schemes (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    scope character varying(32),
    defaultteamadminrole character varying(64),
    defaultteamuserrole character varying(64),
    defaultchanneladminrole character varying(64),
    defaultchanneluserrole character varying(64),
    defaultteamguestrole character varying(64),
    defaultchannelguestrole character varying(64),
    defaultplaybookadminrole character varying(64) DEFAULT ''::character varying,
    defaultplaybookmemberrole character varying(64) DEFAULT ''::character varying,
    defaultrunadminrole character varying(64) DEFAULT ''::character varying,
    defaultrunmemberrole character varying(64) DEFAULT ''::character varying
);


ALTER TABLE public.schemes OWNER TO mmuser;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sessions (
    id character varying(26) NOT NULL,
    token character varying(26),
    createat bigint,
    expiresat bigint,
    lastactivityat bigint,
    userid character varying(26),
    deviceid character varying(512),
    roles character varying(256),
    isoauth boolean,
    props jsonb,
    expirednotify boolean
);


ALTER TABLE public.sessions OWNER TO mmuser;

--
-- Name: sharedchannelattachments; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sharedchannelattachments (
    id character varying(26) NOT NULL,
    fileid character varying(26),
    remoteid character varying(26),
    createat bigint,
    lastsyncat bigint
);


ALTER TABLE public.sharedchannelattachments OWNER TO mmuser;

--
-- Name: sharedchannelremotes; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sharedchannelremotes (
    id character varying(26) NOT NULL,
    channelid character varying(26) NOT NULL,
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    isinviteaccepted boolean,
    isinviteconfirmed boolean,
    remoteid character varying(26),
    lastpostupdateat bigint,
    lastpostid character varying(26),
    lastpostcreateat bigint DEFAULT 0 NOT NULL,
    lastpostcreateid character varying(26)
);


ALTER TABLE public.sharedchannelremotes OWNER TO mmuser;

--
-- Name: sharedchannels; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sharedchannels (
    channelid character varying(26) NOT NULL,
    teamid character varying(26),
    home boolean,
    readonly boolean,
    sharename character varying(64),
    sharedisplayname character varying(64),
    sharepurpose character varying(250),
    shareheader character varying(1024),
    creatorid character varying(26),
    createat bigint,
    updateat bigint,
    remoteid character varying(26)
);


ALTER TABLE public.sharedchannels OWNER TO mmuser;

--
-- Name: sharedchannelusers; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sharedchannelusers (
    id character varying(26) NOT NULL,
    userid character varying(26),
    remoteid character varying(26),
    createat bigint,
    lastsyncat bigint,
    channelid character varying(26)
);


ALTER TABLE public.sharedchannelusers OWNER TO mmuser;

--
-- Name: sidebarcategories; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sidebarcategories (
    id character varying(128) NOT NULL,
    userid character varying(26),
    teamid character varying(26),
    sortorder bigint,
    sorting character varying(64),
    type character varying(64),
    displayname character varying(64),
    muted boolean,
    collapsed boolean
);


ALTER TABLE public.sidebarcategories OWNER TO mmuser;

--
-- Name: sidebarchannels; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.sidebarchannels (
    channelid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    categoryid character varying(128) NOT NULL,
    sortorder bigint
);


ALTER TABLE public.sidebarchannels OWNER TO mmuser;

--
-- Name: status; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.status (
    userid character varying(26) NOT NULL,
    status character varying(32),
    manual boolean,
    lastactivityat bigint,
    dndendtime bigint,
    prevstatus character varying(32)
);


ALTER TABLE public.status OWNER TO mmuser;

--
-- Name: systems; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.systems (
    name character varying(64) NOT NULL,
    value character varying(1024)
);


ALTER TABLE public.systems OWNER TO mmuser;

--
-- Name: teammembers; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.teammembers (
    teamid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    roles character varying(256),
    deleteat bigint,
    schemeuser boolean,
    schemeadmin boolean,
    schemeguest boolean,
    createat bigint DEFAULT 0
);


ALTER TABLE public.teammembers OWNER TO mmuser;

--
-- Name: teams; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.teams (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    displayname character varying(64),
    name character varying(64),
    description character varying(255),
    email character varying(128),
    type public.team_type,
    companyname character varying(64),
    alloweddomains character varying(1000),
    inviteid character varying(32),
    schemeid character varying(26),
    allowopeninvite boolean,
    lastteamiconupdate bigint,
    groupconstrained boolean,
    cloudlimitsarchived boolean DEFAULT false NOT NULL
);


ALTER TABLE public.teams OWNER TO mmuser;

--
-- Name: termsofservice; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.termsofservice (
    id character varying(26) NOT NULL,
    createat bigint,
    userid character varying(26),
    text character varying(65535)
);


ALTER TABLE public.termsofservice OWNER TO mmuser;

--
-- Name: threadmemberships; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.threadmemberships (
    postid character varying(26) NOT NULL,
    userid character varying(26) NOT NULL,
    following boolean,
    lastviewed bigint,
    lastupdated bigint,
    unreadmentions bigint
)
WITH (autovacuum_vacuum_scale_factor='0.1', autovacuum_analyze_scale_factor='0.05');


ALTER TABLE public.threadmemberships OWNER TO mmuser;

--
-- Name: threads; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.threads (
    postid character varying(26) NOT NULL,
    replycount bigint,
    lastreplyat bigint,
    participants jsonb,
    channelid character varying(26),
    threaddeleteat bigint,
    threadteamid character varying(26)
);


ALTER TABLE public.threads OWNER TO mmuser;

--
-- Name: tokens; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.tokens (
    token character varying(64) NOT NULL,
    createat bigint,
    type character varying(64),
    extra character varying(2048)
);


ALTER TABLE public.tokens OWNER TO mmuser;

--
-- Name: trueupreviewhistory; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.trueupreviewhistory (
    duedate bigint NOT NULL,
    completed boolean
);


ALTER TABLE public.trueupreviewhistory OWNER TO mmuser;

--
-- Name: uploadsessions; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.uploadsessions (
    id character varying(26) NOT NULL,
    type public.upload_session_type,
    createat bigint,
    userid character varying(26),
    channelid character varying(26),
    filename character varying(256),
    path character varying(512),
    filesize bigint,
    fileoffset bigint,
    remoteid character varying(26),
    reqfileid character varying(26)
);


ALTER TABLE public.uploadsessions OWNER TO mmuser;

--
-- Name: useraccesstokens; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.useraccesstokens (
    id character varying(26) NOT NULL,
    token character varying(26),
    userid character varying(26),
    description character varying(512),
    isactive boolean
);


ALTER TABLE public.useraccesstokens OWNER TO mmuser;

--
-- Name: usergroups; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.usergroups (
    id character varying(26) NOT NULL,
    name character varying(64),
    displayname character varying(128),
    description character varying(1024),
    source character varying(64),
    remoteid character varying(48),
    createat bigint,
    updateat bigint,
    deleteat bigint,
    allowreference boolean
);


ALTER TABLE public.usergroups OWNER TO mmuser;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.users (
    id character varying(26) NOT NULL,
    createat bigint,
    updateat bigint,
    deleteat bigint,
    username character varying(64),
    password character varying(128),
    authdata character varying(128),
    authservice character varying(32),
    email character varying(128),
    emailverified boolean,
    nickname character varying(64),
    firstname character varying(64),
    lastname character varying(64),
    roles character varying(256),
    allowmarketing boolean,
    props jsonb,
    notifyprops jsonb,
    lastpasswordupdate bigint,
    lastpictureupdate bigint,
    failedattempts integer,
    locale character varying(5),
    mfaactive boolean,
    mfasecret character varying(128),
    "position" character varying(128),
    timezone jsonb,
    remoteid character varying(26),
    lastlogin bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO mmuser;

--
-- Name: usertermsofservice; Type: TABLE; Schema: public; Owner: mmuser
--

CREATE TABLE public.usertermsofservice (
    userid character varying(26) NOT NULL,
    termsofserviceid character varying(26),
    createat bigint
);


ALTER TABLE public.usertermsofservice OWNER TO mmuser;

--
-- Data for Name: audits; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.audits (id, createat, userid, action, extrainfo, ipaddress, sessionid) FROM stdin;
ehy464dyp3ggm8q4wtooiomxmr	1707211272824		/api/v4/users/login	attempt - login_id=admin	192.168.224.1	
e8hr4bgkptd93gqkfzepgrg1nw	1707211272828		/api/v4/users/login	failure - login_id=admin	192.168.224.1	
7yiyfqkrmfggxejbuz5ufptatc	1707211302119	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	attempt - login_id=	192.168.224.1	
oa4cmwbaeing8rew75cgxmwwre	1707211302224	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	authenticated	192.168.224.1	
8xd4ir1f63dhir6aeyetoy9bbh	1707211302240	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	success session_user=e9ezn5tk178umpozs46chzbh7h	192.168.224.1	t53w3k4z1ifo5ejjo6zrck959o
1h9hq174ipg7t813cmiaij4wne	1707211302420	e9ezn5tk178umpozs46chzbh7h	/api/v4/system/onboarding/complete	attempt	192.168.224.1	t53w3k4z1ifo5ejjo6zrck959o
hmqmb3xe8fd7ijghzfic3bzxsy	1707211302429	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/me/patch		192.168.224.1	t53w3k4z1ifo5ejjo6zrck959o
x5f1eocq7fyhmqs7dsmctn6bsa	1707211412843	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/logout		192.168.240.1	t53w3k4z1ifo5ejjo6zrck959o
qmqyxsrnkjgybg85d6gfpunfna	1707211421933		/api/v4/users/login	attempt - login_id=test	192.168.240.1	
e74ckw3757grdyadi49w4wz7zh	1707211422006	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	authenticated	192.168.240.1	
i9mckrxye3yoi8nond44zcpsur	1707211422025	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	success session_user=e9ezn5tk178umpozs46chzbh7h	192.168.240.1	wkrhcxrkujdcz8eggy8qwpd63e
dor8y348ttnj5jirbxyg5sf6rr	1707211627587		/api/v4/users/login	attempt - login_id=test	192.168.240.1	
wtq4gjndrtghzp69kt7ipaqg7y	1707211627671	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	authenticated	192.168.240.1	
p55zb9jwifbdpxayq1xzfrxwza	1707211627688	e9ezn5tk178umpozs46chzbh7h	/api/v4/users/login	success session_user=e9ezn5tk178umpozs46chzbh7h	192.168.240.1	g467xtrkp3fkzxgngh16spu7gw
\.


--
-- Data for Name: bots; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.bots (userid, description, ownerid, createat, updateat, deleteat, lasticonupdate) FROM stdin;
tdoop854d7dcuyame34cgiustc		e9ezn5tk178umpozs46chzbh7h	1707211500009	1707211500009	0	0
\.


--
-- Data for Name: channelmemberhistory; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.channelmemberhistory (channelid, userid, jointime, leavetime) FROM stdin;
rzca4sbu43y47kppuiqr79h3ja	e9ezn5tk178umpozs46chzbh7h	1707211306253	\N
ekn1y3hbnjrfjpet9xdd8f45cw	e9ezn5tk178umpozs46chzbh7h	1707211306269	\N
\.


--
-- Data for Name: channelmembers; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.channelmembers (channelid, userid, roles, lastviewedat, msgcount, mentioncount, notifyprops, lastupdateat, schemeuser, schemeadmin, schemeguest, mentioncountroot, msgcountroot, urgentmentioncount) FROM stdin;
ekn1y3hbnjrfjpet9xdd8f45cw	e9ezn5tk178umpozs46chzbh7h		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default", "channel_auto_follow_threads": "off"}	1707211306264	t	t	f	0	0	0
rzca4sbu43y47kppuiqr79h3ja	e9ezn5tk178umpozs46chzbh7h		0	0	0	{"push": "default", "email": "default", "desktop": "default", "mark_unread": "all", "ignore_channel_mentions": "default", "channel_auto_follow_threads": "off"}	1707211306248	t	t	f	0	0	0
\.


--
-- Data for Name: channels; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.channels (id, createat, updateat, deleteat, teamid, type, displayname, name, header, purpose, lastpostat, totalmsgcount, extraupdateat, creatorid, schemeid, groupconstrained, shared, totalmsgcountroot, lastrootpostat) FROM stdin;
rzca4sbu43y47kppuiqr79h3ja	1707211306218	1707211306218	0	mwqhexop9bfy3yb7sm3eqnwxgc	O	Town Square	town-square			1707211306254	0	0		\N	\N	\N	0	1707211306254
ekn1y3hbnjrfjpet9xdd8f45cw	1707211306231	1707211306231	0	mwqhexop9bfy3yb7sm3eqnwxgc	O	Off-Topic	off-topic			1707211306270	0	0		\N	\N	\N	0	1707211306270
\.


--
-- Data for Name: clusterdiscovery; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.clusterdiscovery (id, type, clustername, hostname, gossipport, port, createat, lastpingat) FROM stdin;
\.


--
-- Data for Name: commands; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.commands (id, token, createat, updateat, deleteat, creatorid, teamid, trigger, method, username, iconurl, autocomplete, autocompletedesc, autocompletehint, displayname, description, url, pluginid) FROM stdin;
\.


--
-- Data for Name: commandwebhooks; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.commandwebhooks (id, createat, commandid, userid, channelid, rootid, usecount) FROM stdin;
\.


--
-- Data for Name: compliances; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.compliances (id, createat, userid, status, count, "desc", type, startat, endat, keywords, emails) FROM stdin;
\.


--
-- Data for Name: db_lock; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.db_lock (id, expireat) FROM stdin;
\.


--
-- Data for Name: db_migrations; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.db_migrations (version, name) FROM stdin;
1	create_teams
2	create_team_members
3	create_cluster_discovery
4	create_command_webhooks
5	create_compliances
6	create_emojis
7	create_user_groups
8	create_group_members
9	create_group_teams
10	create_group_channels
11	create_link_metadata
12	create_commands
13	create_incoming_webhooks
14	create_outgoing_webhooks
15	create_systems
16	create_reactions
17	create_roles
18	create_schemes
19	create_licenses
20	create_posts
21	create_product_notice_view_state
22	create_sessions
23	create_terms_of_service
24	create_audits
25	create_oauth_access_data
26	create_preferences
27	create_status
28	create_tokens
29	create_bots
30	create_user_access_tokens
31	create_remote_clusters
32	create_sharedchannels
33	create_sidebar_channels
34	create_oauthauthdata
35	create_sharedchannelattachments
36	create_sharedchannelusers
37	create_sharedchannelremotes
38	create_jobs
39	create_channel_member_history
40	create_sidebar_categories
41	create_upload_sessions
42	create_threads
43	thread_memberships
44	create_user_terms_of_service
45	create_plugin_key_value_store
46	create_users
47	create_file_info
48	create_oauth_apps
49	create_channels
50	create_channelmembers
51	create_msg_root_count
52	create_public_channels
53	create_retention_policies
54	create_crt_channelmembership_count
55	create_crt_thread_count_and_unreads
56	upgrade_channels_v6.0
57	upgrade_command_webhooks_v6.0
58	upgrade_channelmembers_v6.0
59	upgrade_users_v6.0
60	upgrade_jobs_v6.0
61	upgrade_link_metadata_v6.0
62	upgrade_sessions_v6.0
63	upgrade_threads_v6.0
64	upgrade_status_v6.0
65	upgrade_groupchannels_v6.0
66	upgrade_posts_v6.0
67	upgrade_channelmembers_v6.1
68	upgrade_teammembers_v6.1
69	upgrade_jobs_v6.1
70	upgrade_cte_v6.1
71	upgrade_sessions_v6.1
72	upgrade_schemes_v6.3
73	upgrade_plugin_key_value_store_v6.3
74	upgrade_users_v6.3
75	alter_upload_sessions_index
76	upgrade_lastrootpostat
77	upgrade_users_v6.5
78	create_oauth_mattermost_app_id
79	usergroups_displayname_index
80	posts_createat_id
81	threads_deleteat
82	upgrade_oauth_mattermost_app_id
83	threads_threaddeleteat
84	recent_searches
85	fileinfo_add_archived_column
86	add_cloud_limits_archived
87	sidebar_categories_index
88	remaining_migrations
89	add-channelid-to-reaction
90	create_enums
91	create_post_reminder
92	add_createat_to_teamembers
93	notify_admin
94	threads_teamid
95	remove_posts_parentid
96	threads_threadteamid
97	create_posts_priority
98	create_post_acknowledgements
99	create_drafts
100	add_draft_priority_column
101	create_true_up_review_history
102	posts_originalid_index
103	add_sentat_to_notifyadmin
104	upgrade_notifyadmin
105	remove_tokens
106	fileinfo_channelid
107	threadmemberships_cleanup
108	remove_orphaned_oauth_preferences
109	create_persistent_notifications
111	update_vacuuming
112	rework_desktop_tokens
113	create_retentionidsfordeletion_table
114	sharedchannelremotes_drop_nextsyncat_description
115	user_reporting_changes
116	create_outgoing_oauth_connections
117	msteams_shared_channels
\.


--
-- Data for Name: desktoptokens; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.desktoptokens (token, createat, userid) FROM stdin;
\.


--
-- Data for Name: drafts; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.drafts (createat, updateat, deleteat, userid, channelid, rootid, message, props, fileids, priority) FROM stdin;
\.


--
-- Data for Name: emoji; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.emoji (id, createat, updateat, deleteat, creatorid, name) FROM stdin;
\.


--
-- Data for Name: fileinfo; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.fileinfo (id, creatorid, postid, createat, updateat, deleteat, path, thumbnailpath, previewpath, name, extension, size, mimetype, width, height, haspreviewimage, minipreview, content, remoteid, archived, channelid) FROM stdin;
\.


--
-- Data for Name: groupchannels; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.groupchannels (groupid, autoadd, schemeadmin, createat, deleteat, updateat, channelid) FROM stdin;
\.


--
-- Data for Name: groupmembers; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.groupmembers (groupid, userid, createat, deleteat) FROM stdin;
\.


--
-- Data for Name: groupteams; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.groupteams (groupid, autoadd, schemeadmin, createat, deleteat, updateat, teamid) FROM stdin;
\.


--
-- Data for Name: incomingwebhooks; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.incomingwebhooks (id, createat, updateat, deleteat, userid, channelid, teamid, displayname, description, username, iconurl, channellocked) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.jobs (id, type, priority, createat, startat, lastactivityat, status, progress, data) FROM stdin;
uwq3cagu1jnajke4mi9pz4q9gc	delete_empty_drafts_migration	0	1707211264071	1707211279484	1707211280522	success	100	{}
h81f67zkb3gfmfut4a3y1jzceo	migrations	0	1707211323162	1707211324489	1707211325099	success	0	{"last_done": "{\\"current_table\\":\\"ChannelMembers\\",\\"last_team_id\\":\\"mwqhexop9bfy3yb7sm3eqnwxgc\\",\\"last_channel_id\\":\\"rzca4sbu43y47kppuiqr79h3ja\\",\\"last_user\\":\\"e9ezn5tk178umpozs46chzbh7h\\"}", "migration_key": "migration_advanced_permissions_phase_2"}
\.


--
-- Data for Name: licenses; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.licenses (id, createat, bytes) FROM stdin;
\.


--
-- Data for Name: linkmetadata; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.linkmetadata (hash, url, "timestamp", type, data) FROM stdin;
\.


--
-- Data for Name: notifyadmin; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.notifyadmin (userid, createat, requiredplan, requiredfeature, trial, sentat) FROM stdin;
\.


--
-- Data for Name: oauthaccessdata; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.oauthaccessdata (token, refreshtoken, redirecturi, clientid, userid, expiresat, scope) FROM stdin;
\.


--
-- Data for Name: oauthapps; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.oauthapps (id, creatorid, createat, updateat, clientsecret, name, description, callbackurls, homepage, istrusted, iconurl, mattermostappid) FROM stdin;
\.


--
-- Data for Name: oauthauthdata; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.oauthauthdata (clientid, userid, code, expiresin, createat, redirecturi, state, scope) FROM stdin;
\.


--
-- Data for Name: outgoingoauthconnections; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.outgoingoauthconnections (id, name, creatorid, createat, updateat, clientid, clientsecret, credentialsusername, credentialspassword, oauthtokenurl, granttype, audiences) FROM stdin;
\.


--
-- Data for Name: outgoingwebhooks; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.outgoingwebhooks (id, token, createat, updateat, deleteat, creatorid, channelid, teamid, triggerwords, callbackurls, displayname, contenttype, triggerwhen, username, iconurl, description) FROM stdin;
\.


--
-- Data for Name: persistentnotifications; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.persistentnotifications (postid, createat, lastsentat, deleteat, sentcount) FROM stdin;
\.


--
-- Data for Name: pluginkeyvaluestore; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.pluginkeyvaluestore (pluginid, pkey, pvalue, expireat) FROM stdin;
\.


--
-- Data for Name: postacknowledgements; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.postacknowledgements (postid, userid, acknowledgedat) FROM stdin;
\.


--
-- Data for Name: postreminders; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.postreminders (postid, userid, targettime) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.posts (id, createat, updateat, deleteat, userid, channelid, rootid, originalid, message, type, props, hashtags, filenames, fileids, hasreactions, editat, ispinned, remoteid) FROM stdin;
o4og9e89o3ri5fqkjwrx6rckoa	1707211306254	1707211306254	0	e9ezn5tk178umpozs46chzbh7h	rzca4sbu43y47kppuiqr79h3ja			test joined the team.	system_join_team	{"username": "test"}		[]	[]	f	0	f	\N
uocdp3g5itfi9cxx67tjk6spao	1707211306270	1707211306270	0	e9ezn5tk178umpozs46chzbh7h	ekn1y3hbnjrfjpet9xdd8f45cw			test joined the channel.	system_join_channel	{"username": "test"}		[]	[]	f	0	f	\N
\.


--
-- Data for Name: postspriority; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.postspriority (postid, channelid, priority, requestedack, persistentnotifications) FROM stdin;
\.


--
-- Data for Name: preferences; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.preferences (userid, category, name, value) FROM stdin;
e9ezn5tk178umpozs46chzbh7h	tutorial_step	e9ezn5tk178umpozs46chzbh7h	0
e9ezn5tk178umpozs46chzbh7h	system_notice	GMasDM	true
e9ezn5tk178umpozs46chzbh7h	recommended_next_steps	hide	true
e9ezn5tk178umpozs46chzbh7h	onboarding_task_list	onboarding_task_list_show	false
e9ezn5tk178umpozs46chzbh7h	onboarding_task_list	onboarding_task_list_open	false
e9ezn5tk178umpozs46chzbh7h	channel_approximate_view_time	rzca4sbu43y47kppuiqr79h3ja	1707211408285
e9ezn5tk178umpozs46chzbh7h	touched	add_channels_cta	true
e9ezn5tk178umpozs46chzbh7h	theme		{"awayIndicator":"#f5ab00","buttonBg":"#386fe5","buttonColor":"#ffffff","centerChannelBg":"#090a0b","centerChannelColor":"#dddfe4","codeTheme":"monokai","dndIndicator":"#d24b4e","errorTextColor":"#da6c6e","linkColor":"#5d89ea","mentionBg":"#1c58d9","mentionBj":"#1c58d9","mentionColor":"#ffffff","mentionHighlightBg":"#0d6e6e","mentionHighlightLink":"#a4f4f4","newMessageSeparator":"#1adbdb","onlineIndicator":"#3db887","sidebarBg":"#121317","sidebarHeaderBg":"#1b1d22","sidebarHeaderTextColor":"#dddfe4","sidebarTeamBarBg":"#000000","sidebarText":"#ffffff","sidebarTextActiveBorder":"#1592e0","sidebarTextActiveColor":"#ffffff","sidebarTextHoverBg":"#25262a","sidebarUnreadText":"#ffffff","type":"Onyx"}
\.


--
-- Data for Name: productnoticeviewstate; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.productnoticeviewstate (userid, noticeid, viewed, "timestamp") FROM stdin;
e9ezn5tk178umpozs46chzbh7h	gfycat_deprecation_7.8	1	1707211302
e9ezn5tk178umpozs46chzbh7h	gif_deprecation_7.9_7.10	1	1707211302
e9ezn5tk178umpozs46chzbh7h	gfycat_deprecation_8.0	1	1707211302
e9ezn5tk178umpozs46chzbh7h	gfycat_deprecation_8.1	1	1707211302
e9ezn5tk178umpozs46chzbh7h	boards_deprecations	1	1707211302
e9ezn5tk178umpozs46chzbh7h	boards_deprecations_user_2	1	1707211302
e9ezn5tk178umpozs46chzbh7h	desktop_upgrade_v5.6	1	1707211302
e9ezn5tk178umpozs46chzbh7h	server_upgrade_v9.4	1	1707211302
e9ezn5tk178umpozs46chzbh7h	crt-admin-disabled	1	1707211302
e9ezn5tk178umpozs46chzbh7h	crt-admin-default_off	1	1707211302
e9ezn5tk178umpozs46chzbh7h	crt-user-default-on	1	1707211302
e9ezn5tk178umpozs46chzbh7h	crt-user-always-on	1	1707211302
e9ezn5tk178umpozs46chzbh7h	unsupported-server-v5.37	1	1707211302
\.


--
-- Data for Name: publicchannels; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.publicchannels (id, deleteat, teamid, displayname, name, header, purpose) FROM stdin;
rzca4sbu43y47kppuiqr79h3ja	0	mwqhexop9bfy3yb7sm3eqnwxgc	Town Square	town-square		
ekn1y3hbnjrfjpet9xdd8f45cw	0	mwqhexop9bfy3yb7sm3eqnwxgc	Off-Topic	off-topic		
\.


--
-- Data for Name: reactions; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.reactions (userid, postid, emojiname, createat, updateat, deleteat, remoteid, channelid) FROM stdin;
\.


--
-- Data for Name: recentsearches; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.recentsearches (userid, searchpointer, query, createat) FROM stdin;
\.


--
-- Data for Name: remoteclusters; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.remoteclusters (remoteid, remoteteamid, name, displayname, siteurl, createat, lastpingat, token, remotetoken, topics, creatorid, pluginid) FROM stdin;
\.


--
-- Data for Name: retentionidsfordeletion; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.retentionidsfordeletion (id, tablename, ids) FROM stdin;
\.


--
-- Data for Name: retentionpolicies; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.retentionpolicies (id, displayname, postduration) FROM stdin;
\.


--
-- Data for Name: retentionpolicieschannels; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.retentionpolicieschannels (policyid, channelid) FROM stdin;
\.


--
-- Data for Name: retentionpoliciesteams; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.retentionpoliciesteams (policyid, teamid) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.roles (id, name, displayname, description, createat, updateat, deleteat, permissions, schememanaged, builtin) FROM stdin;
zcn8o9b3y7rudre19zgkmzc9fe	run_member	authentication.roles.run_member.name	authentication.roles.run_member.description	1707211263142	1707211264034	0	 run_view	t	t
xkwtwrtnm3dodxui59u5wcksbh	system_post_all_public	authentication.roles.system_post_all_public.name	authentication.roles.system_post_all_public.description	1707211263160	1707211264045	0	 create_post_public use_group_mentions use_channel_mentions	f	t
u95xwsgmx7reinbodgbsfnzcfr	team_post_all	authentication.roles.team_post_all.name	authentication.roles.team_post_all.description	1707211263154	1707211264039	0	 create_post use_channel_mentions use_group_mentions	f	t
taq7mrr5qpdbjbsmmq9f4mbtgc	custom_group_user	authentication.roles.custom_group_user.name	authentication.roles.custom_group_user.description	1707211263161	1707211264046	0		f	f
8bt641oig3r1xbdoe6qjje77rw	system_user_access_token	authentication.roles.system_user_access_token.name	authentication.roles.system_user_access_token.description	1707211263145	1707211264035	0	 read_user_access_token revoke_user_access_token create_user_access_token	f	t
rswyrky7atf8upchf94ewhu4sy	team_user	authentication.roles.team_user.name	authentication.roles.team_user.description	1707211263146	1707211264036	0	 view_team playbook_public_create create_private_channel join_public_channels create_public_channel read_public_channel list_team_channels invite_user add_user_to_team playbook_private_create	t	t
4q38wmt7b7bp887e15t83inaba	playbook_admin	authentication.roles.playbook_admin.name	authentication.roles.playbook_admin.description	1707211263148	1707211264036	0	 playbook_public_manage_members playbook_public_manage_roles playbook_public_manage_properties playbook_private_manage_members playbook_private_manage_roles playbook_private_manage_properties playbook_public_make_private	t	t
iptfs4oa83gexee4tx9mrbnrhc	team_admin	authentication.roles.team_admin.name	authentication.roles.team_admin.description	1707211263155	1707211264040	0	 create_post delete_post convert_public_channel_to_private remove_reaction remove_user_from_team use_group_mentions manage_others_outgoing_webhooks manage_channel_roles manage_team manage_others_incoming_webhooks delete_others_posts manage_others_slash_commands manage_outgoing_webhooks convert_private_channel_to_public read_private_channel_groups use_channel_mentions playbook_private_manage_roles manage_slash_commands playbook_public_manage_roles manage_private_channel_members manage_incoming_webhooks manage_public_channel_members read_public_channel_groups manage_team_roles add_reaction import_team	t	t
g4r71ohhyfy63pbz9u1bck83hh	channel_user	authentication.roles.channel_user.name	authentication.roles.channel_user.description	1707211263168	1707211264049	0	 read_private_channel_groups use_group_mentions read_channel_content read_public_channel_groups delete_private_channel add_reaction get_public_link delete_post delete_public_channel upload_file manage_private_channel_members manage_private_channel_properties read_channel manage_public_channel_properties remove_reaction manage_public_channel_members edit_post create_post use_channel_mentions	t	t
n35w39tat3fjjj5bzwoh99djzy	system_post_all	authentication.roles.system_post_all.name	authentication.roles.system_post_all.description	1707211263171	1707211264050	0	 use_channel_mentions use_group_mentions create_post	f	t
m5nankpzxjyu5rqafieyqd5etw	channel_admin	authentication.roles.channel_admin.name	authentication.roles.channel_admin.description	1707211263149	1707211264038	0	 read_private_channel_groups manage_channel_roles manage_private_channel_members manage_public_channel_members add_reaction use_channel_mentions read_public_channel_groups use_group_mentions create_post remove_reaction	t	t
f1qb9qendbdi5kzsb3ii1n37bh	team_guest	authentication.roles.team_guest.name	authentication.roles.team_guest.description	1707211263152	1707211264038	0	 view_team	t	t
47hhz4f71bd5bxgr93kx46f74a	playbook_member	authentication.roles.playbook_member.name	authentication.roles.playbook_member.description	1707211263156	1707211264041	0	 run_create playbook_public_view playbook_public_manage_members playbook_public_manage_properties playbook_private_view playbook_private_manage_members playbook_private_manage_properties	t	t
ibxz5q99p7rnbjpjr48p3dt9fr	run_admin	authentication.roles.run_admin.name	authentication.roles.run_admin.description	1707211263157	1707211264042	0	 run_manage_properties run_manage_members	t	t
6qsehbbifpgxzd355trbyyixzo	system_admin	authentication.roles.global_admin.name	authentication.roles.global_admin.description	1707211263164	1707211264051	0	 sysconsole_write_user_management_users sysconsole_read_authentication_email create_bot demote_to_guest get_logs sysconsole_write_environment_rate_limiting create_ldap_sync_job read_bots sysconsole_write_environment_push_notification_server create_direct_channel sysconsole_write_environment_web_server sysconsole_read_site_public_links manage_system sysconsole_write_authentication_guest_access revoke_user_access_token sysconsole_read_billing edit_others_posts edit_custom_group manage_secure_connections playbook_private_manage_properties delete_private_channel assign_bot sysconsole_read_authentication_saml sysconsole_write_user_management_teams sysconsole_write_experimental_bleve add_saml_idp_cert read_private_channel_groups get_analytics manage_jobs sysconsole_write_compliance_compliance_monitoring delete_others_emojis sysconsole_write_authentication_mfa list_public_teams edit_other_users delete_public_channel sysconsole_write_billing sysconsole_write_authentication_ldap manage_license_information sysconsole_read_environment_elasticsearch join_private_teams read_others_bots sysconsole_write_plugins remove_saml_public_cert recycle_database_connections sysconsole_write_authentication_signup read_ldap_sync_job sysconsole_read_reporting_team_statistics remove_ldap_public_cert invite_guest sysconsole_write_integrations_bot_accounts manage_others_incoming_webhooks sysconsole_read_user_management_teams sysconsole_read_user_management_channels sysconsole_read_reporting_server_logs sysconsole_read_experimental_features sysconsole_read_environment_high_availability manage_incoming_webhooks sysconsole_read_user_management_permissions add_ldap_public_cert manage_others_bots create_custom_group playbook_public_manage_members add_reaction sysconsole_write_site_announcement_banner sysconsole_write_site_customization sysconsole_read_authentication_password sysconsole_write_site_notices run_manage_properties read_audits run_create manage_shared_channels sysconsole_read_authentication_signup read_elasticsearch_post_aggregation_job sysconsole_read_compliance_compliance_monitoring view_members sysconsole_read_environment_file_storage get_saml_metadata_from_idp purge_elasticsearch_indexes sysconsole_read_environment_push_notification_server sysconsole_write_compliance_custom_terms_of_service delete_emojis add_ldap_private_cert sysconsole_write_environment_session_lengths sysconsole_read_integrations_cors playbook_private_create sysconsole_write_reporting_site_statistics add_saml_public_cert run_view sysconsole_write_environment_performance_monitoring sysconsole_write_compliance_compliance_export create_post_ephemeral create_elasticsearch_post_indexing_job sysconsole_read_environment_image_proxy manage_public_channel_properties download_compliance_export_result sysconsole_read_authentication_ldap sysconsole_read_products_boards sysconsole_write_authentication_password invalidate_email_invite test_email remove_saml_private_cert sysconsole_read_integrations_integration_management sysconsole_write_environment_developer get_saml_cert_status manage_custom_group_members playbook_public_manage_properties create_user_access_token remove_user_from_team create_data_retention_job join_public_channels sysconsole_write_user_management_permissions sysconsole_read_plugins sysconsole_write_authentication_saml edit_brand playbook_public_view manage_oauth sysconsole_read_experimental_bleve delete_custom_group create_private_channel manage_others_outgoing_webhooks sysconsole_read_site_customization sysconsole_read_site_ip_filters edit_post playbook_public_manage_roles sysconsole_read_user_management_groups sysconsole_write_integrations_integration_management invalidate_caches sysconsole_write_integrations_cors create_post sysconsole_read_user_management_users sysconsole_read_site_emoji read_license_information test_elasticsearch read_compliance_export_job sysconsole_write_site_emoji sysconsole_write_site_users_and_teams sysconsole_write_experimental_features sysconsole_read_authentication_openid sysconsole_read_site_announcement_banner sysconsole_write_site_posts remove_others_reactions sysconsole_write_environment_elasticsearch create_post_public manage_roles sysconsole_read_site_localization sysconsole_write_user_management_channels sysconsole_read_integrations_bot_accounts create_elasticsearch_post_aggregation_job delete_others_posts sysconsole_write_environment_smtp sysconsole_read_site_file_sharing_and_downloads read_public_channel playbook_private_manage_members create_emojis read_other_users_teams manage_channel_roles sysconsole_write_user_management_system_roles sysconsole_read_compliance_custom_terms_of_service get_public_link reload_config manage_slash_commands remove_ldap_private_cert sysconsole_write_site_file_sharing_and_downloads sysconsole_read_user_management_system_roles sysconsole_write_user_management_groups sysconsole_write_environment_high_availability read_public_channel_groups sysconsole_read_site_notices sysconsole_read_environment_session_lengths sysconsole_write_integrations_gif sysconsole_write_environment_logging assign_system_admin_role remove_saml_idp_cert create_team sysconsole_write_site_localization sysconsole_read_compliance_data_retention_policy test_site_url sysconsole_write_site_ip_filters sysconsole_write_authentication_openid read_channel list_users_without_team create_post_bleve_indexes_job sysconsole_write_environment_database manage_bots run_manage_members convert_private_channel_to_public sysconsole_read_experimental_feature_flags manage_team remove_reaction manage_others_slash_commands sysconsole_read_compliance_compliance_export sysconsole_read_environment_rate_limiting create_public_channel manage_public_channel_members purge_bleve_indexes manage_private_channel_members sysconsole_read_environment_logging sysconsole_write_environment_file_storage view_team list_private_teams import_team list_team_channels playbook_private_manage_roles restore_custom_group read_jobs sysconsole_write_about_edition_and_license sysconsole_read_integrations_gif read_user_access_token invite_user manage_outgoing_webhooks upload_file sysconsole_read_site_notifications playbook_private_view use_channel_mentions sysconsole_write_products_boards sysconsole_write_site_notifications sysconsole_read_environment_developer sysconsole_read_environment_performance_monitoring sysconsole_read_environment_smtp sysconsole_read_environment_database use_slash_commands test_ldap read_deleted_posts use_group_mentions sysconsole_read_authentication_mfa sysconsole_write_site_public_links sysconsole_write_reporting_team_statistics sysconsole_read_environment_web_server convert_public_channel_to_private create_compliance_export_job sysconsole_read_site_posts manage_team_roles playbook_private_make_public sysconsole_read_reporting_site_statistics add_user_to_team sysconsole_read_about_edition_and_license playbook_public_create manage_private_channel_properties read_data_retention_job sysconsole_write_reporting_server_logs sysconsole_read_authentication_guest_access read_elasticsearch_post_indexing_job join_public_teams sysconsole_write_compliance_data_retention_policy sysconsole_write_experimental_feature_flags add_saml_private_cert promote_guest manage_system_wide_oauth delete_post sysconsole_write_authentication_email playbook_public_make_private read_channel_content create_group_channel test_s3 sysconsole_write_environment_image_proxy sysconsole_read_site_users_and_teams	t	t
owcq4mrqktfzzkxzsr38iifdzw	system_guest	authentication.roles.global_guest.name	authentication.roles.global_guest.description	1707211263159	1707211264044	0	 create_group_channel create_direct_channel	t	t
r4rtfow4qp8h3jmsia93ftpzfh	team_post_all_public	authentication.roles.team_post_all_public.name	authentication.roles.team_post_all_public.description	1707211263137	1707211264033	0	 use_group_mentions create_post_public use_channel_mentions	f	t
t9d4q839rpyw9k9o6g3sfeuopo	system_manager	authentication.roles.system_manager.name	authentication.roles.system_manager.description	1707211263162	1707211264047	0	 sysconsole_write_integrations_cors sysconsole_read_integrations_cors convert_public_channel_to_private sysconsole_read_site_localization sysconsole_read_reporting_team_statistics sysconsole_read_environment_file_storage sysconsole_read_user_management_teams sysconsole_read_site_public_links invalidate_caches sysconsole_write_environment_high_availability read_public_channel_groups join_public_teams sysconsole_read_site_users_and_teams sysconsole_read_environment_smtp sysconsole_read_integrations_integration_management sysconsole_read_user_management_channels sysconsole_write_environment_image_proxy reload_config sysconsole_write_user_management_teams list_public_teams manage_team sysconsole_write_environment_web_server sysconsole_write_site_customization sysconsole_write_environment_session_lengths sysconsole_read_environment_push_notification_server sysconsole_read_authentication_email sysconsole_write_integrations_bot_accounts convert_private_channel_to_public sysconsole_read_authentication_ldap sysconsole_write_products_boards manage_channel_roles sysconsole_read_site_notices create_elasticsearch_post_aggregation_job sysconsole_read_site_customization sysconsole_write_environment_file_storage manage_public_channel_properties join_private_teams read_elasticsearch_post_indexing_job remove_user_from_team sysconsole_read_authentication_guest_access sysconsole_write_user_management_permissions sysconsole_write_site_notifications read_channel sysconsole_read_user_management_permissions sysconsole_write_environment_push_notification_server sysconsole_read_reporting_site_statistics sysconsole_read_authentication_openid sysconsole_write_user_management_groups sysconsole_read_authentication_saml sysconsole_read_environment_performance_monitoring manage_private_channel_properties read_private_channel_groups sysconsole_read_environment_web_server sysconsole_read_authentication_password test_email manage_public_channel_members recycle_database_connections sysconsole_write_environment_database sysconsole_read_integrations_gif sysconsole_read_environment_image_proxy read_ldap_sync_job get_analytics sysconsole_read_environment_high_availability sysconsole_read_authentication_signup test_site_url sysconsole_write_environment_developer sysconsole_read_site_announcement_banner sysconsole_write_environment_performance_monitoring test_elasticsearch sysconsole_write_site_announcement_banner delete_public_channel sysconsole_write_site_public_links sysconsole_write_site_users_and_teams sysconsole_write_user_management_channels sysconsole_read_plugins sysconsole_write_environment_elasticsearch sysconsole_write_integrations_integration_management sysconsole_write_integrations_gif add_user_to_team sysconsole_read_products_boards sysconsole_read_environment_database sysconsole_write_site_notices sysconsole_write_environment_smtp purge_elasticsearch_indexes delete_private_channel sysconsole_read_environment_rate_limiting read_elasticsearch_post_aggregation_job sysconsole_write_site_emoji edit_brand sysconsole_read_authentication_mfa sysconsole_read_environment_developer sysconsole_write_site_posts sysconsole_read_about_edition_and_license sysconsole_read_reporting_server_logs create_elasticsearch_post_indexing_job sysconsole_read_environment_logging view_team sysconsole_read_site_notifications test_s3 sysconsole_write_environment_logging sysconsole_write_environment_rate_limiting manage_team_roles sysconsole_read_user_management_groups list_private_teams manage_private_channel_members sysconsole_read_site_file_sharing_and_downloads get_logs sysconsole_read_integrations_bot_accounts sysconsole_read_environment_elasticsearch sysconsole_read_site_emoji sysconsole_write_site_file_sharing_and_downloads sysconsole_write_site_localization sysconsole_read_site_posts sysconsole_read_environment_session_lengths read_license_information test_ldap read_public_channel	f	t
bfqhum3unf8hzcjf7p4sx7ykkh	system_user_manager	authentication.roles.system_user_manager.name	authentication.roles.system_user_manager.description	1707211263172	1707211264052	0	 manage_public_channel_properties sysconsole_read_user_management_groups manage_team_roles sysconsole_read_user_management_permissions sysconsole_read_user_management_teams convert_public_channel_to_private list_public_teams sysconsole_read_authentication_ldap sysconsole_read_authentication_signup manage_private_channel_properties sysconsole_write_user_management_groups join_public_teams read_public_channel_groups read_channel sysconsole_read_authentication_password manage_team sysconsole_read_user_management_channels sysconsole_read_authentication_guest_access add_user_to_team sysconsole_write_user_management_teams join_private_teams delete_public_channel sysconsole_read_authentication_openid test_ldap manage_channel_roles view_team sysconsole_read_authentication_mfa manage_private_channel_members list_private_teams read_public_channel read_private_channel_groups read_ldap_sync_job remove_user_from_team sysconsole_read_authentication_email delete_private_channel convert_private_channel_to_public sysconsole_read_authentication_saml sysconsole_write_user_management_channels manage_public_channel_members	f	t
umngazxf87ykbf7n3zgkzdzxuw	system_custom_group_admin	authentication.roles.system_custom_group_admin.name	authentication.roles.system_custom_group_admin.description	1707211263173	1707211264053	0	 manage_custom_group_members create_custom_group edit_custom_group delete_custom_group restore_custom_group	f	t
ghzhqc3zftb9j8gomqritza7ua	channel_guest	authentication.roles.channel_guest.name	authentication.roles.channel_guest.description	1707211263174	1707211264054	0	 create_post use_channel_mentions read_channel read_channel_content add_reaction remove_reaction upload_file edit_post	t	t
kwjpkzeg4irqxm18ynsbjzszwo	system_user	authentication.roles.global_user.name	authentication.roles.global_user.description	1707211263170	1707211264054	0	 create_direct_channel delete_custom_group create_team restore_custom_group delete_emojis edit_custom_group create_custom_group join_public_teams create_group_channel manage_custom_group_members view_members list_public_teams create_emojis	t	t
4hk5fyuqbjdxzds1mbys78tzke	system_read_only_admin	authentication.roles.system_read_only_admin.name	authentication.roles.system_read_only_admin.description	1707211263167	1707211264048	0	 sysconsole_read_plugins sysconsole_read_environment_file_storage read_elasticsearch_post_aggregation_job list_public_teams sysconsole_read_environment_database sysconsole_read_environment_high_availability sysconsole_read_environment_web_server sysconsole_read_user_management_teams get_logs sysconsole_read_environment_elasticsearch sysconsole_read_user_management_permissions sysconsole_read_site_notices sysconsole_read_environment_smtp sysconsole_read_site_users_and_teams download_compliance_export_result sysconsole_read_compliance_compliance_export sysconsole_read_site_localization read_compliance_export_job get_analytics view_team sysconsole_read_user_management_users sysconsole_read_products_boards read_other_users_teams sysconsole_read_experimental_features sysconsole_read_integrations_bot_accounts sysconsole_read_reporting_site_statistics sysconsole_read_site_announcement_banner sysconsole_read_compliance_data_retention_policy sysconsole_read_environment_session_lengths read_data_retention_job sysconsole_read_authentication_ldap sysconsole_read_reporting_team_statistics sysconsole_read_experimental_bleve sysconsole_read_compliance_compliance_monitoring sysconsole_read_authentication_mfa sysconsole_read_site_emoji sysconsole_read_authentication_guest_access sysconsole_read_environment_image_proxy sysconsole_read_site_file_sharing_and_downloads sysconsole_read_integrations_cors sysconsole_read_integrations_gif sysconsole_read_authentication_signup sysconsole_read_authentication_password sysconsole_read_environment_logging sysconsole_read_site_public_links read_audits sysconsole_read_site_posts sysconsole_read_authentication_email sysconsole_read_environment_rate_limiting sysconsole_read_experimental_feature_flags sysconsole_read_environment_performance_monitoring read_license_information sysconsole_read_authentication_saml read_channel sysconsole_read_about_edition_and_license sysconsole_read_environment_push_notification_server sysconsole_read_site_customization read_private_channel_groups sysconsole_read_compliance_custom_terms_of_service test_ldap sysconsole_read_integrations_integration_management sysconsole_read_user_management_channels read_public_channel read_elasticsearch_post_indexing_job sysconsole_read_user_management_groups sysconsole_read_site_notifications list_private_teams read_ldap_sync_job read_public_channel_groups sysconsole_read_environment_developer sysconsole_read_authentication_openid sysconsole_read_reporting_server_logs	f	t
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.schemes (id, name, displayname, description, createat, updateat, deleteat, scope, defaultteamadminrole, defaultteamuserrole, defaultchanneladminrole, defaultchanneluserrole, defaultteamguestrole, defaultchannelguestrole, defaultplaybookadminrole, defaultplaybookmemberrole, defaultrunadminrole, defaultrunmemberrole) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sessions (id, token, createat, expiresat, lastactivityat, userid, deviceid, roles, isoauth, props, expirednotify) FROM stdin;
wkrhcxrkujdcz8eggy8qwpd63e	9gstw54mdifttcmqhi6mco96ce	1707211422019	1709803422019	1707211422019	e9ezn5tk178umpozs46chzbh7h		system_admin system_user	f	{"os": "Linux", "csrf": "fb7hebbaci8em8gd1w9ojh79bo", "isSaml": "false", "browser": "Chrome/121.0", "isMobile": "false", "is_guest": "false", "platform": "Linux", "isOAuthUser": "false"}	f
g467xtrkp3fkzxgngh16spu7gw	yibgymogjpfojqhdin7crgp1ee	1707211627684	1709803627684	1707211627684	e9ezn5tk178umpozs46chzbh7h		system_admin system_user	f	{"os": "Linux", "csrf": "oa9xo7p3cbbwpbexbb73nk1ate", "isSaml": "false", "browser": "Chrome/121.0", "isMobile": "false", "is_guest": "false", "platform": "Linux", "isOAuthUser": "false"}	f
\.


--
-- Data for Name: sharedchannelattachments; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sharedchannelattachments (id, fileid, remoteid, createat, lastsyncat) FROM stdin;
\.


--
-- Data for Name: sharedchannelremotes; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sharedchannelremotes (id, channelid, creatorid, createat, updateat, isinviteaccepted, isinviteconfirmed, remoteid, lastpostupdateat, lastpostid, lastpostcreateat, lastpostcreateid) FROM stdin;
\.


--
-- Data for Name: sharedchannels; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sharedchannels (channelid, teamid, home, readonly, sharename, sharedisplayname, sharepurpose, shareheader, creatorid, createat, updateat, remoteid) FROM stdin;
\.


--
-- Data for Name: sharedchannelusers; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sharedchannelusers (id, userid, remoteid, createat, lastsyncat, channelid) FROM stdin;
\.


--
-- Data for Name: sidebarcategories; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sidebarcategories (id, userid, teamid, sortorder, sorting, type, displayname, muted, collapsed) FROM stdin;
favorites_e9ezn5tk178umpozs46chzbh7h_mwqhexop9bfy3yb7sm3eqnwxgc	e9ezn5tk178umpozs46chzbh7h	mwqhexop9bfy3yb7sm3eqnwxgc	0		favorites	Favorites	f	f
channels_e9ezn5tk178umpozs46chzbh7h_mwqhexop9bfy3yb7sm3eqnwxgc	e9ezn5tk178umpozs46chzbh7h	mwqhexop9bfy3yb7sm3eqnwxgc	10		channels	Channels	f	f
direct_messages_e9ezn5tk178umpozs46chzbh7h_mwqhexop9bfy3yb7sm3eqnwxgc	e9ezn5tk178umpozs46chzbh7h	mwqhexop9bfy3yb7sm3eqnwxgc	20	recent	direct_messages	Direct Messages	f	f
\.


--
-- Data for Name: sidebarchannels; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.sidebarchannels (channelid, userid, categoryid, sortorder) FROM stdin;
\.


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.status (userid, status, manual, lastactivityat, dndendtime, prevstatus) FROM stdin;
e9ezn5tk178umpozs46chzbh7h	offline	f	1707211435725	0	
\.


--
-- Data for Name: systems; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.systems (name, value) FROM stdin;
CRTChannelMembershipCountsMigrationComplete	true
CRTThreadCountsAndUnreadsMigrationComplete	true
AsymmetricSigningKey	{"ecdsa_key":{"curve":"P-256","x":71928739908382042305190931966964067927846490847799011226173975900003480578029,"y":38565779755344163486483655378851674604352700382214690842731034235290562615446,"d":115659222969178498250029177325535695155482193917371618081130815488082574303878}}
DiagnosticId	3jj3qc4y9fddumhhn6kbi3aqcy
LastSecurityTime	1707211263141
FirstServerRunTimestamp	1707211263144
AdvancedPermissionsMigrationComplete	true
EmojisPermissionsMigrationComplete	true
GuestRolesCreationMigrationComplete	true
SystemConsoleRolesCreationMigrationComplete	true
CustomGroupAdminRoleCreationMigrationComplete	true
emoji_permissions_split	true
webhook_permissions_split	true
list_join_public_private_teams	true
remove_permanent_delete_user	true
add_bot_permissions	true
apply_channel_manage_delete_to_channel_user	true
remove_channel_manage_delete_from_team_user	true
view_members_new_permission	true
add_manage_guests_permissions	true
channel_moderations_permissions	true
add_use_group_mentions_permission	true
add_system_console_permissions	true
add_convert_channel_permissions	true
manage_shared_channel_permissions	true
manage_secure_connections_permissions	true
add_system_roles_permissions	true
add_billing_permissions	true
download_compliance_export_results	true
experimental_subsection_permissions	true
authentication_subsection_permissions	true
integrations_subsection_permissions	true
site_subsection_permissions	true
compliance_subsection_permissions	true
environment_subsection_permissions	true
about_subsection_permissions	true
reporting_subsection_permissions	true
test_email_ancillary_permission	true
playbooks_permissions	true
custom_groups_permissions	true
playbooks_manage_roles	true
products_boards	true
custom_groups_permission_restore	true
read_channel_content_permissions	true
add_ip_filtering_permissions	true
ContentExtractionConfigDefaultTrueMigrationComplete	true
PlaybookRolesCreationMigrationComplete	true
RemainingSchemaMigrations	true
PostPriorityConfigDefaultTrueMigrationComplete	true
PostActionCookieSecret	{"key":"zyvuqhxp/AWdpcNvfeVb8zwh5upNgKXSArfbzR6bccE="}
InstallationDate	1707211264186
delete_empty_drafts_migration	true
OrganizationName	test-org
FirstAdminSetupComplete	true
migration_advanced_permissions_phase_2	true
\.


--
-- Data for Name: teammembers; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.teammembers (teamid, userid, roles, deleteat, schemeuser, schemeadmin, schemeguest, createat) FROM stdin;
mwqhexop9bfy3yb7sm3eqnwxgc	e9ezn5tk178umpozs46chzbh7h		0	t	t	f	1707211306234
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.teams (id, createat, updateat, deleteat, displayname, name, description, email, type, companyname, alloweddomains, inviteid, schemeid, allowopeninvite, lastteamiconupdate, groupconstrained, cloudlimitsarchived) FROM stdin;
mwqhexop9bfy3yb7sm3eqnwxgc	1707211306186	1707211306186	0	test-org	test-org		test@test.com	O			cwuoaxzfxtgzpyxd1c8dyqqgma		f	0	f	f
\.


--
-- Data for Name: termsofservice; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.termsofservice (id, createat, userid, text) FROM stdin;
\.


--
-- Data for Name: threadmemberships; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.threadmemberships (postid, userid, following, lastviewed, lastupdated, unreadmentions) FROM stdin;
\.


--
-- Data for Name: threads; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.threads (postid, replycount, lastreplyat, participants, channelid, threaddeleteat, threadteamid) FROM stdin;
\.


--
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.tokens (token, createat, type, extra) FROM stdin;
\.


--
-- Data for Name: trueupreviewhistory; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.trueupreviewhistory (duedate, completed) FROM stdin;
\.


--
-- Data for Name: uploadsessions; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.uploadsessions (id, type, createat, userid, channelid, filename, path, filesize, fileoffset, remoteid, reqfileid) FROM stdin;
\.


--
-- Data for Name: useraccesstokens; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.useraccesstokens (id, token, userid, description, isactive) FROM stdin;
\.


--
-- Data for Name: usergroups; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.usergroups (id, name, displayname, description, source, remoteid, createat, updateat, deleteat, allowreference) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.users (id, createat, updateat, deleteat, username, password, authdata, authservice, email, emailverified, nickname, firstname, lastname, roles, allowmarketing, props, notifyprops, lastpasswordupdate, lastpictureupdate, failedattempts, locale, mfaactive, mfasecret, "position", timezone, remoteid, lastlogin) FROM stdin;
tdoop854d7dcuyame34cgiustc	1707211500003	1707211500003	0	system-bot		\N		system-bot@localhost	f		System		system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1707211500003	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "", "useAutomaticTimezone": "true"}	\N	0
e9ezn5tk178umpozs46chzbh7h	1707211302020	1707211627686	0	test	$2a$10$VRyno4fN3RstewOOxVM5GOsxxfa5h2dTn0bPQICwo/RJlJgjsdFme	\N		test@test.com	f				system_admin system_user	f	{}	{"push": "mention", "email": "true", "channel": "true", "desktop": "mention", "comments": "never", "first_name": "false", "push_status": "away", "mention_keys": "", "push_threads": "all", "desktop_sound": "true", "email_threads": "all", "desktop_threads": "all"}	1707211302020	0	0	en	f			{"manualTimezone": "", "automaticTimezone": "Asia/Calcutta", "useAutomaticTimezone": "true"}	\N	1707211627684
\.


--
-- Data for Name: usertermsofservice; Type: TABLE DATA; Schema: public; Owner: mmuser
--

COPY public.usertermsofservice (userid, termsofserviceid, createat) FROM stdin;
\.


--
-- Name: audits audits_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.audits
    ADD CONSTRAINT audits_pkey PRIMARY KEY (id);


--
-- Name: bots bots_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.bots
    ADD CONSTRAINT bots_pkey PRIMARY KEY (userid);


--
-- Name: channelmemberhistory channelmemberhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.channelmemberhistory
    ADD CONSTRAINT channelmemberhistory_pkey PRIMARY KEY (channelid, userid, jointime);


--
-- Name: channelmembers channelmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.channelmembers
    ADD CONSTRAINT channelmembers_pkey PRIMARY KEY (channelid, userid);


--
-- Name: channels channels_name_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_name_teamid_key UNIQUE (name, teamid);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: clusterdiscovery clusterdiscovery_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.clusterdiscovery
    ADD CONSTRAINT clusterdiscovery_pkey PRIMARY KEY (id);


--
-- Name: commands commands_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.commands
    ADD CONSTRAINT commands_pkey PRIMARY KEY (id);


--
-- Name: commandwebhooks commandwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.commandwebhooks
    ADD CONSTRAINT commandwebhooks_pkey PRIMARY KEY (id);


--
-- Name: compliances compliances_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.compliances
    ADD CONSTRAINT compliances_pkey PRIMARY KEY (id);


--
-- Name: db_lock db_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.db_lock
    ADD CONSTRAINT db_lock_pkey PRIMARY KEY (id);


--
-- Name: db_migrations db_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.db_migrations
    ADD CONSTRAINT db_migrations_pkey PRIMARY KEY (version);


--
-- Name: desktoptokens desktoptokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.desktoptokens
    ADD CONSTRAINT desktoptokens_pkey PRIMARY KEY (token);


--
-- Name: drafts drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (userid, channelid, rootid);


--
-- Name: emoji emoji_name_deleteat_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_name_deleteat_key UNIQUE (name, deleteat);


--
-- Name: emoji emoji_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.emoji
    ADD CONSTRAINT emoji_pkey PRIMARY KEY (id);


--
-- Name: fileinfo fileinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.fileinfo
    ADD CONSTRAINT fileinfo_pkey PRIMARY KEY (id);


--
-- Name: groupchannels groupchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.groupchannels
    ADD CONSTRAINT groupchannels_pkey PRIMARY KEY (groupid, channelid);


--
-- Name: groupmembers groupmembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.groupmembers
    ADD CONSTRAINT groupmembers_pkey PRIMARY KEY (groupid, userid);


--
-- Name: groupteams groupteams_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.groupteams
    ADD CONSTRAINT groupteams_pkey PRIMARY KEY (groupid, teamid);


--
-- Name: incomingwebhooks incomingwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.incomingwebhooks
    ADD CONSTRAINT incomingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: licenses licenses_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.licenses
    ADD CONSTRAINT licenses_pkey PRIMARY KEY (id);


--
-- Name: linkmetadata linkmetadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.linkmetadata
    ADD CONSTRAINT linkmetadata_pkey PRIMARY KEY (hash);


--
-- Name: notifyadmin notifyadmin_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.notifyadmin
    ADD CONSTRAINT notifyadmin_pkey PRIMARY KEY (userid, requiredfeature, requiredplan);


--
-- Name: oauthaccessdata oauthaccessdata_clientid_userid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.oauthaccessdata
    ADD CONSTRAINT oauthaccessdata_clientid_userid_key UNIQUE (clientid, userid);


--
-- Name: oauthaccessdata oauthaccessdata_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.oauthaccessdata
    ADD CONSTRAINT oauthaccessdata_pkey PRIMARY KEY (token);


--
-- Name: oauthapps oauthapps_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.oauthapps
    ADD CONSTRAINT oauthapps_pkey PRIMARY KEY (id);


--
-- Name: oauthauthdata oauthauthdata_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.oauthauthdata
    ADD CONSTRAINT oauthauthdata_pkey PRIMARY KEY (code);


--
-- Name: outgoingoauthconnections outgoingoauthconnections_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.outgoingoauthconnections
    ADD CONSTRAINT outgoingoauthconnections_pkey PRIMARY KEY (id);


--
-- Name: outgoingwebhooks outgoingwebhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.outgoingwebhooks
    ADD CONSTRAINT outgoingwebhooks_pkey PRIMARY KEY (id);


--
-- Name: persistentnotifications persistentnotifications_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.persistentnotifications
    ADD CONSTRAINT persistentnotifications_pkey PRIMARY KEY (postid);


--
-- Name: pluginkeyvaluestore pluginkeyvaluestore_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.pluginkeyvaluestore
    ADD CONSTRAINT pluginkeyvaluestore_pkey PRIMARY KEY (pluginid, pkey);


--
-- Name: postacknowledgements postacknowledgements_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.postacknowledgements
    ADD CONSTRAINT postacknowledgements_pkey PRIMARY KEY (postid, userid);


--
-- Name: postreminders postreminders_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.postreminders
    ADD CONSTRAINT postreminders_pkey PRIMARY KEY (postid, userid);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: postspriority postspriority_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.postspriority
    ADD CONSTRAINT postspriority_pkey PRIMARY KEY (postid);


--
-- Name: preferences preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.preferences
    ADD CONSTRAINT preferences_pkey PRIMARY KEY (userid, category, name);


--
-- Name: productnoticeviewstate productnoticeviewstate_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.productnoticeviewstate
    ADD CONSTRAINT productnoticeviewstate_pkey PRIMARY KEY (userid, noticeid);


--
-- Name: publicchannels publicchannels_name_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.publicchannels
    ADD CONSTRAINT publicchannels_name_teamid_key UNIQUE (name, teamid);


--
-- Name: publicchannels publicchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.publicchannels
    ADD CONSTRAINT publicchannels_pkey PRIMARY KEY (id);


--
-- Name: reactions reactions_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.reactions
    ADD CONSTRAINT reactions_pkey PRIMARY KEY (postid, userid, emojiname);


--
-- Name: recentsearches recentsearches_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.recentsearches
    ADD CONSTRAINT recentsearches_pkey PRIMARY KEY (userid, searchpointer);


--
-- Name: remoteclusters remoteclusters_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.remoteclusters
    ADD CONSTRAINT remoteclusters_pkey PRIMARY KEY (remoteid, name);


--
-- Name: retentionidsfordeletion retentionidsfordeletion_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.retentionidsfordeletion
    ADD CONSTRAINT retentionidsfordeletion_pkey PRIMARY KEY (id);


--
-- Name: retentionpolicies retentionpolicies_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.retentionpolicies
    ADD CONSTRAINT retentionpolicies_pkey PRIMARY KEY (id);


--
-- Name: retentionpolicieschannels retentionpolicieschannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.retentionpolicieschannels
    ADD CONSTRAINT retentionpolicieschannels_pkey PRIMARY KEY (channelid);


--
-- Name: retentionpoliciesteams retentionpoliciesteams_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.retentionpoliciesteams
    ADD CONSTRAINT retentionpoliciesteams_pkey PRIMARY KEY (teamid);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schemes schemes_name_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_name_key UNIQUE (name);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelattachments sharedchannelattachments_fileid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannelattachments
    ADD CONSTRAINT sharedchannelattachments_fileid_remoteid_key UNIQUE (fileid, remoteid);


--
-- Name: sharedchannelattachments sharedchannelattachments_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannelattachments
    ADD CONSTRAINT sharedchannelattachments_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelremotes sharedchannelremotes_channelid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannelremotes
    ADD CONSTRAINT sharedchannelremotes_channelid_remoteid_key UNIQUE (channelid, remoteid);


--
-- Name: sharedchannelremotes sharedchannelremotes_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannelremotes
    ADD CONSTRAINT sharedchannelremotes_pkey PRIMARY KEY (id, channelid);


--
-- Name: sharedchannels sharedchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannels
    ADD CONSTRAINT sharedchannels_pkey PRIMARY KEY (channelid);


--
-- Name: sharedchannels sharedchannels_sharename_teamid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannels
    ADD CONSTRAINT sharedchannels_sharename_teamid_key UNIQUE (sharename, teamid);


--
-- Name: sharedchannelusers sharedchannelusers_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannelusers
    ADD CONSTRAINT sharedchannelusers_pkey PRIMARY KEY (id);


--
-- Name: sharedchannelusers sharedchannelusers_userid_channelid_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sharedchannelusers
    ADD CONSTRAINT sharedchannelusers_userid_channelid_remoteid_key UNIQUE (userid, channelid, remoteid);


--
-- Name: sidebarcategories sidebarcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sidebarcategories
    ADD CONSTRAINT sidebarcategories_pkey PRIMARY KEY (id);


--
-- Name: sidebarchannels sidebarchannels_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.sidebarchannels
    ADD CONSTRAINT sidebarchannels_pkey PRIMARY KEY (channelid, userid, categoryid);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (userid);


--
-- Name: systems systems_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.systems
    ADD CONSTRAINT systems_pkey PRIMARY KEY (name);


--
-- Name: teammembers teammembers_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.teammembers
    ADD CONSTRAINT teammembers_pkey PRIMARY KEY (teamid, userid);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: termsofservice termsofservice_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.termsofservice
    ADD CONSTRAINT termsofservice_pkey PRIMARY KEY (id);


--
-- Name: threadmemberships threadmemberships_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.threadmemberships
    ADD CONSTRAINT threadmemberships_pkey PRIMARY KEY (postid, userid);


--
-- Name: threads threads_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.threads
    ADD CONSTRAINT threads_pkey PRIMARY KEY (postid);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (token);


--
-- Name: trueupreviewhistory trueupreviewhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.trueupreviewhistory
    ADD CONSTRAINT trueupreviewhistory_pkey PRIMARY KEY (duedate);


--
-- Name: uploadsessions uploadsessions_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.uploadsessions
    ADD CONSTRAINT uploadsessions_pkey PRIMARY KEY (id);


--
-- Name: useraccesstokens useraccesstokens_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.useraccesstokens
    ADD CONSTRAINT useraccesstokens_pkey PRIMARY KEY (id);


--
-- Name: useraccesstokens useraccesstokens_token_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.useraccesstokens
    ADD CONSTRAINT useraccesstokens_token_key UNIQUE (token);


--
-- Name: usergroups usergroups_name_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_name_key UNIQUE (name);


--
-- Name: usergroups usergroups_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_pkey PRIMARY KEY (id);


--
-- Name: usergroups usergroups_source_remoteid_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.usergroups
    ADD CONSTRAINT usergroups_source_remoteid_key UNIQUE (source, remoteid);


--
-- Name: users users_authdata_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_authdata_key UNIQUE (authdata);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: usertermsofservice usertermsofservice_pkey; Type: CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.usertermsofservice
    ADD CONSTRAINT usertermsofservice_pkey PRIMARY KEY (userid);


--
-- Name: idx_audits_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_audits_user_id ON public.audits USING btree (userid);


--
-- Name: idx_channel_search_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channel_search_txt ON public.channels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_channelmembers_channel_id_scheme_guest_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channelmembers_channel_id_scheme_guest_user_id ON public.channelmembers USING btree (channelid, schemeguest, userid);


--
-- Name: idx_channelmembers_user_id_channel_id_last_viewed_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channelmembers_user_id_channel_id_last_viewed_at ON public.channelmembers USING btree (userid, channelid, lastviewedat);


--
-- Name: idx_channels_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_create_at ON public.channels USING btree (createat);


--
-- Name: idx_channels_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_delete_at ON public.channels USING btree (deleteat);


--
-- Name: idx_channels_displayname_lower; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_displayname_lower ON public.channels USING btree (lower((displayname)::text));


--
-- Name: idx_channels_name_lower; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_name_lower ON public.channels USING btree (lower((name)::text));


--
-- Name: idx_channels_scheme_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_scheme_id ON public.channels USING btree (schemeid);


--
-- Name: idx_channels_team_id_display_name; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_team_id_display_name ON public.channels USING btree (teamid, displayname);


--
-- Name: idx_channels_team_id_type; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_team_id_type ON public.channels USING btree (teamid, type);


--
-- Name: idx_channels_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_channels_update_at ON public.channels USING btree (updateat);


--
-- Name: idx_command_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_command_create_at ON public.commands USING btree (createat);


--
-- Name: idx_command_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_command_delete_at ON public.commands USING btree (deleteat);


--
-- Name: idx_command_team_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_command_team_id ON public.commands USING btree (teamid);


--
-- Name: idx_command_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_command_update_at ON public.commands USING btree (updateat);


--
-- Name: idx_command_webhook_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_command_webhook_create_at ON public.commandwebhooks USING btree (createat);


--
-- Name: idx_desktoptokens_token_createat; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_desktoptokens_token_createat ON public.desktoptokens USING btree (token, createat);


--
-- Name: idx_emoji_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_emoji_create_at ON public.emoji USING btree (createat);


--
-- Name: idx_emoji_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_emoji_delete_at ON public.emoji USING btree (deleteat);


--
-- Name: idx_emoji_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_emoji_update_at ON public.emoji USING btree (updateat);


--
-- Name: idx_fileinfo_channel_id_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_channel_id_create_at ON public.fileinfo USING btree (channelid, createat);


--
-- Name: idx_fileinfo_content_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_content_txt ON public.fileinfo USING gin (to_tsvector('english'::regconfig, content));


--
-- Name: idx_fileinfo_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_create_at ON public.fileinfo USING btree (createat);


--
-- Name: idx_fileinfo_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_delete_at ON public.fileinfo USING btree (deleteat);


--
-- Name: idx_fileinfo_extension_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_extension_at ON public.fileinfo USING btree (extension);


--
-- Name: idx_fileinfo_name_splitted; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_name_splitted ON public.fileinfo USING gin (to_tsvector('english'::regconfig, translate((name)::text, '.,-'::text, '   '::text)));


--
-- Name: idx_fileinfo_name_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_name_txt ON public.fileinfo USING gin (to_tsvector('english'::regconfig, (name)::text));


--
-- Name: idx_fileinfo_postid_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_postid_at ON public.fileinfo USING btree (postid);


--
-- Name: idx_fileinfo_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_fileinfo_update_at ON public.fileinfo USING btree (updateat);


--
-- Name: idx_groupchannels_channelid; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_groupchannels_channelid ON public.groupchannels USING btree (channelid);


--
-- Name: idx_groupchannels_schemeadmin; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_groupchannels_schemeadmin ON public.groupchannels USING btree (schemeadmin);


--
-- Name: idx_groupmembers_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_groupmembers_create_at ON public.groupmembers USING btree (createat);


--
-- Name: idx_groupteams_schemeadmin; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_groupteams_schemeadmin ON public.groupteams USING btree (schemeadmin);


--
-- Name: idx_groupteams_teamid; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_groupteams_teamid ON public.groupteams USING btree (teamid);


--
-- Name: idx_incoming_webhook_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_incoming_webhook_create_at ON public.incomingwebhooks USING btree (createat);


--
-- Name: idx_incoming_webhook_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_incoming_webhook_delete_at ON public.incomingwebhooks USING btree (deleteat);


--
-- Name: idx_incoming_webhook_team_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_incoming_webhook_team_id ON public.incomingwebhooks USING btree (teamid);


--
-- Name: idx_incoming_webhook_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_incoming_webhook_update_at ON public.incomingwebhooks USING btree (updateat);


--
-- Name: idx_incoming_webhook_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_incoming_webhook_user_id ON public.incomingwebhooks USING btree (userid);


--
-- Name: idx_jobs_status_type; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_jobs_status_type ON public.jobs USING btree (status, type);


--
-- Name: idx_jobs_type; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_jobs_type ON public.jobs USING btree (type);


--
-- Name: idx_link_metadata_url_timestamp; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_link_metadata_url_timestamp ON public.linkmetadata USING btree (url, "timestamp");


--
-- Name: idx_notice_views_notice_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_notice_views_notice_id ON public.productnoticeviewstate USING btree (noticeid);


--
-- Name: idx_notice_views_timestamp; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_notice_views_timestamp ON public.productnoticeviewstate USING btree ("timestamp");


--
-- Name: idx_oauthaccessdata_refresh_token; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_oauthaccessdata_refresh_token ON public.oauthaccessdata USING btree (refreshtoken);


--
-- Name: idx_oauthaccessdata_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_oauthaccessdata_user_id ON public.oauthaccessdata USING btree (userid);


--
-- Name: idx_oauthapps_creator_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_oauthapps_creator_id ON public.oauthapps USING btree (creatorid);


--
-- Name: idx_outgoing_webhook_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_outgoing_webhook_create_at ON public.outgoingwebhooks USING btree (createat);


--
-- Name: idx_outgoing_webhook_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_outgoing_webhook_delete_at ON public.outgoingwebhooks USING btree (deleteat);


--
-- Name: idx_outgoing_webhook_team_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_outgoing_webhook_team_id ON public.outgoingwebhooks USING btree (teamid);


--
-- Name: idx_outgoing_webhook_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_outgoing_webhook_update_at ON public.outgoingwebhooks USING btree (updateat);


--
-- Name: idx_outgoingoauthconnections_name; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_outgoingoauthconnections_name ON public.outgoingoauthconnections USING btree (name);


--
-- Name: idx_postreminders_targettime; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_postreminders_targettime ON public.postreminders USING btree (targettime);


--
-- Name: idx_posts_channel_id_delete_at_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_channel_id_delete_at_create_at ON public.posts USING btree (channelid, deleteat, createat);


--
-- Name: idx_posts_channel_id_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_channel_id_update_at ON public.posts USING btree (channelid, updateat);


--
-- Name: idx_posts_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_create_at ON public.posts USING btree (createat);


--
-- Name: idx_posts_create_at_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_create_at_id ON public.posts USING btree (createat, id);


--
-- Name: idx_posts_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_delete_at ON public.posts USING btree (deleteat);


--
-- Name: idx_posts_hashtags_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_hashtags_txt ON public.posts USING gin (to_tsvector('english'::regconfig, (hashtags)::text));


--
-- Name: idx_posts_is_pinned; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_is_pinned ON public.posts USING btree (ispinned);


--
-- Name: idx_posts_message_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_message_txt ON public.posts USING gin (to_tsvector('english'::regconfig, (message)::text));


--
-- Name: idx_posts_original_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_original_id ON public.posts USING btree (originalid);


--
-- Name: idx_posts_root_id_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_root_id_delete_at ON public.posts USING btree (rootid, deleteat);


--
-- Name: idx_posts_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_update_at ON public.posts USING btree (updateat);


--
-- Name: idx_posts_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_posts_user_id ON public.posts USING btree (userid);


--
-- Name: idx_preferences_category; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_preferences_category ON public.preferences USING btree (category);


--
-- Name: idx_preferences_name; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_preferences_name ON public.preferences USING btree (name);


--
-- Name: idx_publicchannels_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_publicchannels_delete_at ON public.publicchannels USING btree (deleteat);


--
-- Name: idx_publicchannels_displayname_lower; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_publicchannels_displayname_lower ON public.publicchannels USING btree (lower((displayname)::text));


--
-- Name: idx_publicchannels_name_lower; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_publicchannels_name_lower ON public.publicchannels USING btree (lower((name)::text));


--
-- Name: idx_publicchannels_search_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_publicchannels_search_txt ON public.publicchannels USING gin (to_tsvector('english'::regconfig, (((((name)::text || ' '::text) || (displayname)::text) || ' '::text) || (purpose)::text)));


--
-- Name: idx_publicchannels_team_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_publicchannels_team_id ON public.publicchannels USING btree (teamid);


--
-- Name: idx_reactions_channel_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_reactions_channel_id ON public.reactions USING btree (channelid);


--
-- Name: idx_retentionidsfordeletion_tablename; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_retentionidsfordeletion_tablename ON public.retentionidsfordeletion USING btree (tablename);


--
-- Name: idx_retentionpolicies_displayname; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_retentionpolicies_displayname ON public.retentionpolicies USING btree (displayname);


--
-- Name: idx_retentionpolicieschannels_policyid; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_retentionpolicieschannels_policyid ON public.retentionpolicieschannels USING btree (policyid);


--
-- Name: idx_retentionpoliciesteams_policyid; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_retentionpoliciesteams_policyid ON public.retentionpoliciesteams USING btree (policyid);


--
-- Name: idx_schemes_channel_admin_role; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_schemes_channel_admin_role ON public.schemes USING btree (defaultchanneladminrole);


--
-- Name: idx_schemes_channel_guest_role; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_schemes_channel_guest_role ON public.schemes USING btree (defaultchannelguestrole);


--
-- Name: idx_schemes_channel_user_role; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_schemes_channel_user_role ON public.schemes USING btree (defaultchanneluserrole);


--
-- Name: idx_sessions_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sessions_create_at ON public.sessions USING btree (createat);


--
-- Name: idx_sessions_expires_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sessions_expires_at ON public.sessions USING btree (expiresat);


--
-- Name: idx_sessions_last_activity_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sessions_last_activity_at ON public.sessions USING btree (lastactivityat);


--
-- Name: idx_sessions_token; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sessions_token ON public.sessions USING btree (token);


--
-- Name: idx_sessions_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sessions_user_id ON public.sessions USING btree (userid);


--
-- Name: idx_sharedchannelusers_remote_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sharedchannelusers_remote_id ON public.sharedchannelusers USING btree (remoteid);


--
-- Name: idx_sidebarcategories_userid_teamid; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_sidebarcategories_userid_teamid ON public.sidebarcategories USING btree (userid, teamid);


--
-- Name: idx_status_status_dndendtime; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_status_status_dndendtime ON public.status USING btree (status, dndendtime);


--
-- Name: idx_teammembers_createat; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teammembers_createat ON public.teammembers USING btree (createat);


--
-- Name: idx_teammembers_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teammembers_delete_at ON public.teammembers USING btree (deleteat);


--
-- Name: idx_teammembers_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teammembers_user_id ON public.teammembers USING btree (userid);


--
-- Name: idx_teams_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teams_create_at ON public.teams USING btree (createat);


--
-- Name: idx_teams_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teams_delete_at ON public.teams USING btree (deleteat);


--
-- Name: idx_teams_invite_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teams_invite_id ON public.teams USING btree (inviteid);


--
-- Name: idx_teams_scheme_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teams_scheme_id ON public.teams USING btree (schemeid);


--
-- Name: idx_teams_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_teams_update_at ON public.teams USING btree (updateat);


--
-- Name: idx_thread_memberships_last_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_thread_memberships_last_update_at ON public.threadmemberships USING btree (lastupdated);


--
-- Name: idx_thread_memberships_last_view_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_thread_memberships_last_view_at ON public.threadmemberships USING btree (lastviewed);


--
-- Name: idx_thread_memberships_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_thread_memberships_user_id ON public.threadmemberships USING btree (userid);


--
-- Name: idx_threads_channel_id_last_reply_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_threads_channel_id_last_reply_at ON public.threads USING btree (channelid, lastreplyat);


--
-- Name: idx_uploadsessions_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_uploadsessions_create_at ON public.uploadsessions USING btree (createat);


--
-- Name: idx_uploadsessions_type; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_uploadsessions_type ON public.uploadsessions USING btree (type);


--
-- Name: idx_uploadsessions_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_uploadsessions_user_id ON public.uploadsessions USING btree (userid);


--
-- Name: idx_user_access_tokens_user_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_user_access_tokens_user_id ON public.useraccesstokens USING btree (userid);


--
-- Name: idx_usergroups_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_usergroups_delete_at ON public.usergroups USING btree (deleteat);


--
-- Name: idx_usergroups_displayname; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_usergroups_displayname ON public.usergroups USING btree (displayname);


--
-- Name: idx_usergroups_remote_id; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_usergroups_remote_id ON public.usergroups USING btree (remoteid);


--
-- Name: idx_users_all_no_full_name_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_all_no_full_name_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((username)::text || ' '::text) || (nickname)::text) || ' '::text) || (email)::text)));


--
-- Name: idx_users_all_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_all_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((((((username)::text || ' '::text) || (firstname)::text) || ' '::text) || (lastname)::text) || ' '::text) || (nickname)::text) || ' '::text) || (email)::text)));


--
-- Name: idx_users_create_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_create_at ON public.users USING btree (createat);


--
-- Name: idx_users_delete_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_delete_at ON public.users USING btree (deleteat);


--
-- Name: idx_users_email_lower_textpattern; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_email_lower_textpattern ON public.users USING btree (lower((email)::text) text_pattern_ops);


--
-- Name: idx_users_firstname_lower_textpattern; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_firstname_lower_textpattern ON public.users USING btree (lower((firstname)::text) text_pattern_ops);


--
-- Name: idx_users_lastname_lower_textpattern; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_lastname_lower_textpattern ON public.users USING btree (lower((lastname)::text) text_pattern_ops);


--
-- Name: idx_users_names_no_full_name_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_names_no_full_name_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((username)::text || ' '::text) || (nickname)::text)));


--
-- Name: idx_users_names_txt; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_names_txt ON public.users USING gin (to_tsvector('english'::regconfig, (((((((username)::text || ' '::text) || (firstname)::text) || ' '::text) || (lastname)::text) || ' '::text) || (nickname)::text)));


--
-- Name: idx_users_nickname_lower_textpattern; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_nickname_lower_textpattern ON public.users USING btree (lower((nickname)::text) text_pattern_ops);


--
-- Name: idx_users_update_at; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_update_at ON public.users USING btree (updateat);


--
-- Name: idx_users_username_lower_textpattern; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE INDEX idx_users_username_lower_textpattern ON public.users USING btree (lower((username)::text) text_pattern_ops);


--
-- Name: remote_clusters_site_url_unique; Type: INDEX; Schema: public; Owner: mmuser
--

CREATE UNIQUE INDEX remote_clusters_site_url_unique ON public.remoteclusters USING btree (siteurl, remoteteamid);


--
-- Name: retentionpolicieschannels fk_retentionpolicieschannels_retentionpolicies; Type: FK CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.retentionpolicieschannels
    ADD CONSTRAINT fk_retentionpolicieschannels_retentionpolicies FOREIGN KEY (policyid) REFERENCES public.retentionpolicies(id) ON DELETE CASCADE;


--
-- Name: retentionpoliciesteams fk_retentionpoliciesteams_retentionpolicies; Type: FK CONSTRAINT; Schema: public; Owner: mmuser
--

ALTER TABLE ONLY public.retentionpoliciesteams
    ADD CONSTRAINT fk_retentionpoliciesteams_retentionpolicies FOREIGN KEY (policyid) REFERENCES public.retentionpolicies(id) ON DELETE CASCADE;


--
-- Name: poststats; Type: MATERIALIZED VIEW DATA; Schema: public; Owner: mmuser
--

REFRESH MATERIALIZED VIEW public.poststats;


--
-- PostgreSQL database dump complete
--

