PGDMP  3    	                 |            thrift_store    16.0 (Debian 16.0-1.pgdg120+1)    16.1 O    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    24651    thrift_store    DATABASE     w   CREATE DATABASE thrift_store WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE thrift_store;
                postgres    false            �            1259    24652    advert_favorites    TABLE     t   CREATE TABLE public.advert_favorites (
    favorite_id bigint NOT NULL,
    user_id bigint,
    advert_id bigint
);
 $   DROP TABLE public.advert_favorites;
       public         heap    postgres    false            �            1259    24655     advert_favorites_favorite_id_seq    SEQUENCE     �   ALTER TABLE public.advert_favorites ALTER COLUMN favorite_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.advert_favorites_favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    24656    advert_images    TABLE     �   CREATE TABLE public.advert_images (
    images_id bigint NOT NULL,
    advert_id bigint NOT NULL,
    is_cover_image boolean DEFAULT false NOT NULL,
    url text NOT NULL,
    path text NOT NULL,
    width bigint NOT NULL,
    height bigint NOT NULL
);
 !   DROP TABLE public.advert_images;
       public         heap    postgres    false            �            1259    24662    advert_images_images_id_seq    SEQUENCE     �   ALTER TABLE public.advert_images ALTER COLUMN images_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.advert_images_images_id_seq
    START WITH 123000
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    24663    advert_status    TABLE     �   CREATE TABLE public.advert_status (
    id bigint NOT NULL,
    display_name text NOT NULL,
    is_visible boolean DEFAULT true NOT NULL
);
 !   DROP TABLE public.advert_status;
       public         heap    postgres    false            �            1259    24669    advert_status_id_seq    SEQUENCE     �   ALTER TABLE public.advert_status ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.advert_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    24670    adverts    TABLE     �  CREATE TABLE public.adverts (
    id bigint NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    is_visible boolean DEFAULT true NOT NULL,
    is_deleted boolean DEFAULT false,
    user_id bigint,
    price bigint,
    status_id bigint DEFAULT 2,
    city_id bigint,
    county_id bigint,
    main_category_id bigint NOT NULL,
    sub_category_id bigint,
    is_sell boolean DEFAULT false NOT NULL
);
    DROP TABLE public.adverts;
       public         heap    postgres    false            �            1259    24680    adverts_id_seq    SEQUENCE     �   ALTER TABLE public.adverts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.adverts_id_seq
    START WITH 1200305859
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            �            1259    24681    cities    TABLE     �   CREATE TABLE public.cities (
    id integer NOT NULL,
    plateno character(2) NOT NULL,
    city character varying(50) NOT NULL
);
    DROP TABLE public.cities;
       public         heap    postgres    false            �            1259    24684    cities_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.cities_id_seq;
       public          postgres    false    223            �           0    0    cities_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;
          public          postgres    false    224            �            1259    24685    counties    TABLE     �   CREATE TABLE public.counties (
    id integer NOT NULL,
    city_id integer NOT NULL,
    county character varying(50) NOT NULL
);
    DROP TABLE public.counties;
       public         heap    postgres    false            �            1259    24688    counties_id_seq    SEQUENCE     �   CREATE SEQUENCE public.counties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.counties_id_seq;
       public          postgres    false    225            �           0    0    counties_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.counties_id_seq OWNED BY public.counties.id;
          public          postgres    false    226            �            1259    24689    main_categories    TABLE     �   CREATE TABLE public.main_categories (
    category_id bigint NOT NULL,
    category_name text NOT NULL,
    is_visible boolean DEFAULT true NOT NULL,
    color text NOT NULL
);
 #   DROP TABLE public.main_categories;
       public         heap    postgres    false            �            1259    24695    main_categories_category_id_seq    SEQUENCE     �   ALTER TABLE public.main_categories ALTER COLUMN category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.main_categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227            �            1259    24696    sub_categories    TABLE     �   CREATE TABLE public.sub_categories (
    sub_category_id bigint NOT NULL,
    main_category_id bigint NOT NULL,
    sub_category_name text NOT NULL,
    is_visible boolean DEFAULT true NOT NULL,
    icon text
);
 "   DROP TABLE public.sub_categories;
       public         heap    postgres    false            �            1259    24702 "   sub_categories_sub_category_id_seq    SEQUENCE     �   ALTER TABLE public.sub_categories ALTER COLUMN sub_category_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sub_categories_sub_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    229            �            1259    24703    users    TABLE     W  CREATE TABLE public.users (
    id integer NOT NULL,
    fullname text NOT NULL,
    email text NOT NULL,
    about text,
    is_verify boolean DEFAULT true NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    phone_number bigint,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    password text,
    photo json
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    24711    users_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1467
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    231            �           2604    24712 	   cities id    DEFAULT     f   ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);
 8   ALTER TABLE public.cities ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223            �           2604    24713    counties id    DEFAULT     j   ALTER TABLE ONLY public.counties ALTER COLUMN id SET DEFAULT nextval('public.counties_id_seq'::regclass);
 :   ALTER TABLE public.counties ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    225            w          0    24652    advert_favorites 
   TABLE DATA           K   COPY public.advert_favorites (favorite_id, user_id, advert_id) FROM stdin;
    public          postgres    false    215   `       y          0    24656    advert_images 
   TABLE DATA           g   COPY public.advert_images (images_id, advert_id, is_cover_image, url, path, width, height) FROM stdin;
    public          postgres    false    217   5`       {          0    24663    advert_status 
   TABLE DATA           E   COPY public.advert_status (id, display_name, is_visible) FROM stdin;
    public          postgres    false    219   j�       }          0    24670    adverts 
   TABLE DATA           �   COPY public.adverts (id, title, description, created_at, is_visible, is_deleted, user_id, price, status_id, city_id, county_id, main_category_id, sub_category_id, is_sell) FROM stdin;
    public          postgres    false    221   ��                 0    24681    cities 
   TABLE DATA           3   COPY public.cities (id, plateno, city) FROM stdin;
    public          postgres    false    223   �       �          0    24685    counties 
   TABLE DATA           7   COPY public.counties (id, city_id, county) FROM stdin;
    public          postgres    false    225   ��       �          0    24689    main_categories 
   TABLE DATA           X   COPY public.main_categories (category_id, category_name, is_visible, color) FROM stdin;
    public          postgres    false    227   �      �          0    24696    sub_categories 
   TABLE DATA           p   COPY public.sub_categories (sub_category_id, main_category_id, sub_category_name, is_visible, icon) FROM stdin;
    public          postgres    false    229   =      �          0    24703    users 
   TABLE DATA           }   COPY public.users (id, fullname, email, about, is_verify, is_deleted, phone_number, created_at, password, photo) FROM stdin;
    public          postgres    false    231   >      �           0    0     advert_favorites_favorite_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.advert_favorites_favorite_id_seq', 86, true);
          public          postgres    false    216            �           0    0    advert_images_images_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.advert_images_images_id_seq', 123278, true);
          public          postgres    false    218            �           0    0    advert_status_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.advert_status_id_seq', 5, true);
          public          postgres    false    220            �           0    0    adverts_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.adverts_id_seq', 1200305966, true);
          public          postgres    false    222            �           0    0    cities_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.cities_id_seq', 1, false);
          public          postgres    false    224            �           0    0    counties_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.counties_id_seq', 1, false);
          public          postgres    false    226            �           0    0    main_categories_category_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.main_categories_category_id_seq', 10, true);
          public          postgres    false    228            �           0    0 "   sub_categories_sub_category_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.sub_categories_sub_category_id_seq', 83, true);
          public          postgres    false    230            �           0    0    users_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.users_id_seq', 1483, true);
          public          postgres    false    232            �           2606    24715 &   advert_favorites advert_favorites_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.advert_favorites
    ADD CONSTRAINT advert_favorites_pkey PRIMARY KEY (favorite_id);
 P   ALTER TABLE ONLY public.advert_favorites DROP CONSTRAINT advert_favorites_pkey;
       public            postgres    false    215            �           2606    24717     advert_images advert_images_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.advert_images
    ADD CONSTRAINT advert_images_pkey PRIMARY KEY (images_id);
 J   ALTER TABLE ONLY public.advert_images DROP CONSTRAINT advert_images_pkey;
       public            postgres    false    217            �           2606    24719     advert_status advert_status_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.advert_status
    ADD CONSTRAINT advert_status_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.advert_status DROP CONSTRAINT advert_status_pkey;
       public            postgres    false    219            �           2606    24721    adverts adverts_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT adverts_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.adverts DROP CONSTRAINT adverts_pkey;
       public            postgres    false    221            �           2606    24723    cities cities_city_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_city_key UNIQUE (city);
 @   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_city_key;
       public            postgres    false    223            �           2606    24725    cities cities_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_pkey;
       public            postgres    false    223            �           2606    24727    cities cities_plateno_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_plateno_key UNIQUE (plateno);
 C   ALTER TABLE ONLY public.cities DROP CONSTRAINT cities_plateno_key;
       public            postgres    false    223            �           2606    24729 $   counties counties_city_id_county_key 
   CONSTRAINT     j   ALTER TABLE ONLY public.counties
    ADD CONSTRAINT counties_city_id_county_key UNIQUE (city_id, county);
 N   ALTER TABLE ONLY public.counties DROP CONSTRAINT counties_city_id_county_key;
       public            postgres    false    225    225            �           2606    24731    counties counties_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.counties
    ADD CONSTRAINT counties_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.counties DROP CONSTRAINT counties_pkey;
       public            postgres    false    225            �           2606    24733 $   main_categories main_categories_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.main_categories
    ADD CONSTRAINT main_categories_pkey PRIMARY KEY (category_id);
 N   ALTER TABLE ONLY public.main_categories DROP CONSTRAINT main_categories_pkey;
       public            postgres    false    227            �           2606    24735 "   sub_categories sub_categories_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT sub_categories_pkey PRIMARY KEY (sub_category_id);
 L   ALTER TABLE ONLY public.sub_categories DROP CONSTRAINT sub_categories_pkey;
       public            postgres    false    229            �           2606    24737    users user_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT user_pkey;
       public            postgres    false    231            �           1259    24738    fki_a    INDEX     E   CREATE INDEX fki_a ON public.advert_favorites USING btree (user_id);
    DROP INDEX public.fki_a;
       public            postgres    false    215            �           1259    24739    fki_advert_favorites    INDEX     X   CREATE INDEX fki_advert_favorites ON public.advert_favorites USING btree (favorite_id);
 (   DROP INDEX public.fki_advert_favorites;
       public            postgres    false    215            �           1259    24740    fki_city_advert    INDEX     F   CREATE INDEX fki_city_advert ON public.adverts USING btree (city_id);
 #   DROP INDEX public.fki_city_advert;
       public            postgres    false    221            �           1259    24741    fki_counties_advert    INDEX     L   CREATE INDEX fki_counties_advert ON public.adverts USING btree (county_id);
 '   DROP INDEX public.fki_counties_advert;
       public            postgres    false    221            �           1259    24742    fki_favorite_advert    INDEX     U   CREATE INDEX fki_favorite_advert ON public.advert_favorites USING btree (advert_id);
 '   DROP INDEX public.fki_favorite_advert;
       public            postgres    false    215            �           1259    24743    fki_favorite_user    INDEX     Q   CREATE INDEX fki_favorite_user ON public.advert_favorites USING btree (user_id);
 %   DROP INDEX public.fki_favorite_user;
       public            postgres    false    215            �           1259    24744    fki_image_advert    INDEX     O   CREATE INDEX fki_image_advert ON public.advert_images USING btree (advert_id);
 $   DROP INDEX public.fki_image_advert;
       public            postgres    false    217            �           1259    24745    fki_main_category_advert    INDEX     X   CREATE INDEX fki_main_category_advert ON public.adverts USING btree (main_category_id);
 ,   DROP INDEX public.fki_main_category_advert;
       public            postgres    false    221            �           1259    24746    fki_s    INDEX     L   CREATE INDEX fki_s ON public.sub_categories USING btree (main_category_id);
    DROP INDEX public.fki_s;
       public            postgres    false    229            �           1259    24747    fki_status_adverts    INDEX     K   CREATE INDEX fki_status_adverts ON public.adverts USING btree (status_id);
 &   DROP INDEX public.fki_status_adverts;
       public            postgres    false    221            �           1259    24748    fki_sub_category_advert    INDEX     V   CREATE INDEX fki_sub_category_advert ON public.adverts USING btree (sub_category_id);
 +   DROP INDEX public.fki_sub_category_advert;
       public            postgres    false    221            �           1259    24749    fki_users_advert    INDEX     G   CREATE INDEX fki_users_advert ON public.adverts USING btree (user_id);
 $   DROP INDEX public.fki_users_advert;
       public            postgres    false    221            �           2606    24750    adverts city_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT city_advert FOREIGN KEY (city_id) REFERENCES public.cities(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 =   ALTER TABLE ONLY public.adverts DROP CONSTRAINT city_advert;
       public          postgres    false    3279    223    221            �           2606    24755    adverts counties_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT counties_advert FOREIGN KEY (county_id) REFERENCES public.counties(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 A   ALTER TABLE ONLY public.adverts DROP CONSTRAINT counties_advert;
       public          postgres    false    3285    221    225            �           2606    24760    counties counties_city_id_fkey    FK CONSTRAINT     ~   ALTER TABLE ONLY public.counties
    ADD CONSTRAINT counties_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id);
 H   ALTER TABLE ONLY public.counties DROP CONSTRAINT counties_city_id_fkey;
       public          postgres    false    225    3279    223            �           2606    24765     advert_favorites favorite_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.advert_favorites
    ADD CONSTRAINT favorite_advert FOREIGN KEY (advert_id) REFERENCES public.adverts(id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;
 J   ALTER TABLE ONLY public.advert_favorites DROP CONSTRAINT favorite_advert;
       public          postgres    false    3269    221    215            �           2606    24770    advert_favorites favorite_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.advert_favorites
    ADD CONSTRAINT favorite_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;
 H   ALTER TABLE ONLY public.advert_favorites DROP CONSTRAINT favorite_user;
       public          postgres    false    215    231    3292            �           2606    24775    advert_images image_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.advert_images
    ADD CONSTRAINT image_advert FOREIGN KEY (advert_id) REFERENCES public.adverts(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 D   ALTER TABLE ONLY public.advert_images DROP CONSTRAINT image_advert;
       public          postgres    false    3269    217    221            �           2606    24780 &   sub_categories main_and_sub_categories    FK CONSTRAINT     �   ALTER TABLE ONLY public.sub_categories
    ADD CONSTRAINT main_and_sub_categories FOREIGN KEY (main_category_id) REFERENCES public.main_categories(category_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 P   ALTER TABLE ONLY public.sub_categories DROP CONSTRAINT main_and_sub_categories;
       public          postgres    false    229    3287    227            �           2606    24785    adverts main_category_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT main_category_advert FOREIGN KEY (main_category_id) REFERENCES public.main_categories(category_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 F   ALTER TABLE ONLY public.adverts DROP CONSTRAINT main_category_advert;
       public          postgres    false    227    3287    221            �           2606    24790    adverts status_adverts    FK CONSTRAINT     �   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT status_adverts FOREIGN KEY (status_id) REFERENCES public.advert_status(id) ON UPDATE CASCADE ON DELETE SET NULL NOT VALID;
 @   ALTER TABLE ONLY public.adverts DROP CONSTRAINT status_adverts;
       public          postgres    false    3267    219    221            �           2606    24795    adverts sub_category_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT sub_category_advert FOREIGN KEY (sub_category_id) REFERENCES public.sub_categories(sub_category_id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 E   ALTER TABLE ONLY public.adverts DROP CONSTRAINT sub_category_advert;
       public          postgres    false    229    3290    221            �           2606    24800    adverts users_advert    FK CONSTRAINT     �   ALTER TABLE ONLY public.adverts
    ADD CONSTRAINT users_advert FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;
 >   ALTER TABLE ONLY public.adverts DROP CONSTRAINT users_advert;
       public          postgres    false    221    3292    231            w   $   x��0�4�4420060�4��0C�p��qqq w?      y      x��W���%���
�T��	-Ƭm��O��ұ���,�6����LVvUVq*�hF�������\y�� �	�  P����ڶi�?�i��%.��^�c���T��=���j��������$�1���ӴN���������>�|Y*�%��u����o�� e�ݷW�ّ/���_���-o̓����H>_�	~�|;y���x����,~q� �P�D�/��9Ri���+��w͓x����֬�1m������8�:��{���Q�y���>|�$�����a��b8� � ���r��}��G�����x2��DW[�R�ޕX��M������	�1�R?�*�c*y��	�e����&3��.�Y5��G
�氹J�[��y�x�V�7��	Y#T�+L���	'*�����^(lY�z�ު!��W�/w�g�LlG�;#cx�3R���6^���\ �B`��f�ؾ�t��0�S��+De(�\z7"'�(G��3#j��X�����xd9��Z�5��-�� )�s��m��~�v���Ȼ�C�Nz��y����Ε�/�Jؗ���A[�X��O0���ӿ
������������T?�H�	Q�s�����%I��!I�/ ILD(D��2�h�P��E�u0+D�4��0�Q6�HY�	@�,(��q�Bj�@z>(KV⸙�qp�\bZ���{}dk�[>�4�)���暵dR���;�u��9�� ��/��`[X߬V��� /�,�J�	�
��� w�"P��z������V���|�j�d}hK��Q6|�]����#�ém.«g>[�sg�I*���cv�������ʛ�f?������!Y��������7�P	�+;���?D?@��V�|P�PR��L
�)H�/�@���O�����Qx~�|�B@8D~�YeV!��n}>>؍/�6�R�M?�Ui��(ϷSw��`i��d�܊VY�H��MG�'��R�N�܆ �C�W_�S� ��Y(S����	83壃i n�9b��Xp�>�h�ʙ9C��t�D�|�i�7^-#Uh��ܫXbh#��e�c"8H�_��:��(�]ž�қE��)���/7ɞD~�3��bL�s�����q(��ؽ����K�%�%���lK;�0.�E��@��y�Z��
��"/�VF�C�j���R�ڙ��N�{�7�_���0GH�;����0��/�yOR�)�aU���z	�rr����#�b�J0
E%걛\쪇�ID�O�@�1��:���A�mgc��u�+���NVU�l�r���X}��.r*c6����H_���W��n�b�^�7|�򐩛W��+��&��w�CLI�>r��Mq"���qT�IDXJ��+�-�� l�����^�sо�޴\W�U�����}>��`���ѵפ�����ۜJ�mQz�g�u+*ֻ{�T�%˳���;��fH[�P���è�kii6�	�� hB>>��|��oz�5���8���y����\�?s��WA�~�����+j��*�V��.Ú�a��@�^>����ˤ�)��2[�|���'���,� f<#[�"�0��zy3�dђp�.��O ���W.I��'`X�*��/���C>��4�:V��@��浚�Ub���uґ�1��FL�RB���Ed��@��t�N���[�T�`hIh�,���lZ�Փ�X]��{�W���+�Gw�C�,��%�K�h��4N�Z�`iKR��*#7�'E������y�<nݑ&-6��Q�ז�/�?,���?l�	�;̱��0'� �4X!ª-F��j��z�;3gP��fz.�<��te����e�(:t��i;!3\��1�D�85��b�Xꅯ��NNf�R��k��G������R�Cu�����,�1�����֤�$�gs_���!@+�/��l��xE�f@6��g=0c�9B<�_�Ő��_�6���%B
����}޴\HF
Ux��j�e�9$5��ewE�^��4%(�b��"�����QL��z�;�cD
/���.�i��帯���PgM��Mݰ��/�?ў�ğ��b�?���W�2�`�Ǹ�������[�FM�=χ��50����>^�?&�@ �"d��m<ܧ�	B�`G`�#��v�{"��ejG���u�B1c3-�@�o���ʓb�I������te�EV���y��7��bډ�$�<�M��	�|���Ơuo��t�
Sر��}�30I�=}��Jr�E��W<W�*�@��[�	&����.�0�R�I�4�"^��&,M��Q&�8]z��$z�k�p���c�(��y���O2w|�KN3y.m���O��sO�3H�Zݓ����jBg�m�c�
�g��E��A��^I�����K`��3�~����o�O0�	A��<�/|��� ���~\��%��#^�}������� �.e����PDp F HN] ���L؎�M��xBl�* a>��(��:�5�x*����
[�uD'`Pӫ�v�~@�+`�aQ��6b��8���(��v/S�3�nT�p?��K�b�W*��<f,�sZg�y)�T$����!���C_ƞ������%L�<+�'��ťΡ9���=i���5�[5օ|<2���VydӃ�{ ���l�E%����n�oxD�re!A�
��#R0�t��i�7#ڗA➥j�+���p���j�������X�*cVs�9���f��Mp}������߀ԟ�7����%K�Б��|E����I�y�W�D��Bo}I��\���#>�km�Z��W�m��}��zN�`��-�o)��`9K���^N16�������#?�r�c��OR��	"�a]��]�]Oh��.O���n��7��8���ُ�~a�+����\|󶸜HT�u�JN	��-�J���
��ä��skEi��|�`~�������<��`êE(z>���fe@���z�P�M@��l�!���\��wI� ��X:`ҷ��3`@�{�f�F��k�����S�k��n���b	���%���uQ{΅�kZ�n4����W����n��ԙ<Ūc��Y�tB1�qp�?���w��n�K�D�O�<��py�<�i��Ș��c�n�i�x(�f�P��j��8��w���<��`�%�[�\Hh!�)$m����mDc���Qψc��'���*���t��J���3�&�x���1
$}���2���_a[S �Ic����q�.�}[I����O�k[�*&���O �,]��O���D�;fe)�
��U�Nfo�7X�J���N�:���?6)f�>*���~���ϑ?<���?ד����Я��П��̗��c�����i����Oa$��_�����6Ѐ�+�]�A�J������ź��R� )��(����7�l"�ct�~A���.�����'�q5/�4�^!����+�X�y=J]-�cbB�.��$BAZ�4f�x�;���=]eр�+q��U4'6�{��8�����wK�O�B�I����[��ȏ�qIn*�apƵ��ռٹ'�r���h��w+T�9e��Y:v�����.�����
�ⴏ�7�w������ .6<|�ԹD↸����ԗ����Vw���̀��6O
��i8I��_�����bP�j�պ�E7L��A�B��ѭ��t������](��m1���@xp�O�D��lWЕ4��v�O�+�U�*�+ka��3���(Ө]^]bRHG��H��h�XY��$}���^zu���ݨ�l4��J2җC���a!9�Ϗa���^˫G�!��z���)>13�q����DR���eѐ�ͧ�1�Z�6^�HJ+�rl�O���s�t5o�+j�y0�t,ځ���%z����;+�H&&��jq~8��{�!I�&�Db��9��7)@�	G�?���]	�wC�+�s�Ϳ�o�":�?�)q�m�2��e���z�҅P�j�-���kz�k�5n`�41��Y��D�S?|ǭ���    ��1�)A��$�B�kN+F�t	Դ���PX�k�,p��/�^�Ậq�@����S夰��Ө=!�c����<͇��Σ�)��?��GF��D��!=��Xm�Z��	  �S9W�(���>3s�ci�n���7C82��16�
��?��ĚݎL[+aێ�C�"��o��;�v�DNh9d��W٫M�:J�Zŗ�u�鞀�d |��޵ ~?D�
����Ȗ�Ө�iI���{��-&���GI��j���*);�l��<�A7��FC�<2�p��;P^�{Ƽc-�V*|��wA��z<�f�e�-��]�6�G���X@�Pk��`e=��΋�2�s}���0K�8 uٌw�=���{��d�2��ޏ�<���ECe=�_�(��r��2�*&(	�
��26� �x����O�a�8�r�}F�)+~�fr`G�{Qi�21��e�i�T$^z�Q�5��5{F���'y|�O:M}���xT2�D����ϧ��T q���-��W6��;�t�Y
��|��0���,'�ɣ�-)��;m�ymP��;3��}�II�^�x&ǧN�On�x��ª7�$�1ƃ��hXw8��o���PPT�q=����/BDEߝ�[�z�[D�"[6r�Q?$�N!��
,*�����><��i���nd��
���j<�6;����v�`n�C����T����r�/�># ��t:�ɮsek/�ܹ�{:�b����Bk^F;��ehh��=Y�z{4�!
 �p����dʡ�"1�p�t����_g���gʗ��=ud���sF=��7�>aV��%���>�.��ҕ�����G��Q>(��h��K�'�Z�,��#�I�Ow1�C��M3����Y�Զ.���O(OBU%��w��\���?m��	>y�=���vu��7-� ?
���vr�+�L�杭�B����<Dq)]H#���\$��L�B���{x��?�"�+�E>*k�}�z�6�5�H��+(�7ˉ
��]�ך��^b��P<.�����Z��9���m��}S�9B���9O�Y�ʭؐU+�?���u���Mt�%�l4x�_����-�A�8T��<�~��8x���ncV�y�UH�Z�Pt��4��=�����Ӊ��W�¤��
^�����m���Ju@����k�6����%���5x��V ,,���LQ:��f��hxȱ���*y�-�b���7�����R�^��ǉ�\E�������z/鹣��d�Y���X6���V	��F���eE-��Vj�Lr�'�:ٸ7>�A{A�>���w�.�b�4 s�^��fn�v��WN���M��VZ>��o�?�[1��:��~/�'��ȫ�vV_���1�>��@uo��S�{_k|�� �_V+��7
�S	Y��*�>V�|,C͇mɗ�d{�lv��(�:Y��6{�CJ�E��'��B���֖�#3���u�7'�ӱ��7+�ں)8/~ap��=�"�O��v�84NN��i-j�DcT���z�?���a͓cϬ���fvHqd9�$�y4K�s��Ӧ��5|_}P�5��?�|�Ӳ�� �Zg�g6^2����`���K��.ɐV�5�t��5Z��P[+2�C8��.n�7���˯��~��ik��W4@�Q
$����d02!�v�v�b�c�J6�G�V��h�ꕜ:q7�P�1��^���s�$�ч���i�7B�G�T�#?͏Թ*`IL�\�`M ���ᛯkc�O|B���H��(��O$d��HѤ�'���aά�4knL�c )�Ӻ@�O���y�iM�&PO�{=�Y��݈5M<Q�^���I�*�z���-����f���5��:�d=��[.4��1�{�o�;�|�i3���(?l�On`&�~���4gV�Y��ou�M�? ���@~?��h��/#��i9��e%��w:����Q'��~bd5zggy�/\Tr�E��`�D�BVkݭ��-�2��I���le�o["G���z�l�G����g�:s��/YVu�ºs�D�z0Q������ -����>�i;��!{��8�V��7�ۄ5i
�	��>�%���|�Ŀb�,�v�b�50�m�[�Ҕ��L�Sg�*�ӳ!,ͅC�W>�����=�6z~�$o���I�]��G�r���-�!Ъ]OI���CZ�Yի���]0���O�'�! �;��_꽿��q�7�~A��M=����[Q�Z�"�X��w�U>�؆m�i��F�(�iC;�S�_&�W�cuJ��v&y��y&�%�+P�<	hi�A��u�}v�y�T͒��H�M�]_����T���P(�+$�֙� ��+��x#��D�|�ڷ1�V7�ؠ����=���Oŧ�2h���09x�i[���x�h%��$��0*M\0���~���#_'-�(iN�]��ct\z���d��$�-��N��R'ZTŧ^jŎ'��C��85	S}����s�����
�ߨ��|�)K���(zb�qx1W�;��@��TT��#��\Q���ɛ���׀��a��
��E�y�ok޸�k�%
H1XN����I���|��G�����KK�3������u�F�{�p���V�)�$�ι7T�/��:�M\���%W���� �R���^wm���D�>In'�O'ļ.iJ|�<���g�MH�h�',�?�����O��=��#x>if��x����cuA�j�K����������
 ? )�^�PЙ}�����*��*_QIj&T�.J��Q��u-^�j�yuSF4s�be���cz��OI^zl�NA%݂��uÉ�*m��z_��0 @�=�hF� �TAJ��+�匛׻�z.�g+.4R��1���" [����а�s]�u��ɒ��k�8^��i�r�\��ǈ׹4���
/�ȝ_������Ԫ��t���j>¦ŮCH�>��(l}�6�ݚ1�}˷�=�ޱ�L�>�A�(Q�Z&L��0-�җ,�-kEVhN�M��T�H���˨�Qb۔F[�l�ÿ¯ M��Y�T������T��׿Հ ��c�W�r���gSfA+�՞�]�O�X5�d��Z*�!��l��ԯ�8�[u�L�ꆳ�O:�y�Y���|������ܽ�q�	2�a�^�������D�̴'���`�,3�T��U�1aJY.%n�FyJ�2�4�;��_p��`���\Jz+**�� �2��:�8z���K:���F��5��@!�K2tl�3�B�a���F<���`�k���6��*?����&�1+80�rny�b1� �^��sd:���L�/�6U��7s�q���?����b���5��
_�7�T���t�FIq7�O&����,�'��S�&?e�K�L��k����k�є�r�|J��'�O�_a�V��=h�(�)�}�ɸס#jQS�o�� :�fHO7�i��R��ˣFj)T�P���w�'�s�����$<�y�=�뢣Bm��9��ȭ�����3���tB�`��`,^�����!n�̘��a�r�'o?{��x;!쩐�1�i�:S�͑J�U�p���x�Y�G7��T�d���\������~o{�;��}��E����������q��M�G���F��ҕ�Ǭ�
�wz� �	m� �m���CY�75[�A��D!�ub���t�����m��d��J��� G�C�%�kE"W'N0G�)J���+ʰ:�i�0����E^2��V*��_K�6[L��?���B�x��M}R��J�Ez�̃@ނ�(���b:���m�|��(�;Y��r�NJ�"O�� Lk�˷�$Ja�Ʌ�����"8��y�'oO8��ΧB � )�v�5�cw@��ԢǑ�<H�\�����-�|�4�o���8_�r���1�"X*H=#��gy
��'�畮DO!�{����,�d�#�guaɤ��;�X�e�����kzgV�89?�dz,�9S΂��s_�CY�GRԂ���0�]�    f&Ő�1�u������S��4Ʈ
�\}K�侙o3L'��?V���w_�8d�*���:��Gh�����&�U<��������5�2�N�O����ӌ@�_<\֨�m�uj�7����>�M.���+�ţ��Wud�,�;#�>����& b*14ʻ�����	��L8�+6��[6��W$�.��k�~��$Γ�ؚ�Ά����7au�-_y!�e�L(Dqe�epj��bEq��4!	�Ө�$�z���}[�K��ߥ�2�ҹ��t�c�P��y�)V�)��T {�G�����)-'^���!;���5OX�����+�h��.�VFy�ԅ��s5�]�QÕ���O_D�)V�8yyb����ht�~��^������g@�Pug���Ξ�;�T!"0MK���MJ����'��dn^#�ٝ|�e���|�lge{�BI��i���������v�f�3�`�����@�A�_Yn���a���_��V�L��(�a��C?�E���Lz.�f��enŻ{P8�&|>�G��0��X�4b-S�gB\���ko��VGYT^�f�[%�9B��l�ϰA}.Q��-�����>����M��y$��/ݎ���畸��o����'� tj;+��.�F�� {7Y�kF�;`���p1`��b��_9"�s m�2j��Qb�|R��,���9��m��Xz{e�`F�ѳ��i���=}.=��^Zr�F�eL�_�gt�F�ej�Ɣv:����~N�9��VWE�����s��J�_�����#0��߀�?�d�O֡�/I�u��?L�+t���
��ن� �x1*�'�e9��SU�N�}&0���t��δ��kz}��9���C㿿|�MK1��>UN�nS,���J@�2�z�M�,��{�[sWi�5�J��P@��um>5�*�ߏgxg��	��eV�D�oyD!�wEq�µ
�!� �g�S~[�p�����:,����s��wk}ۀ	�j�t�;C���$�DD�4�^����O2�z���|{zpm�w�l�T(q�%�^rӪ5X����QGѨ2�3�3�
�-�\��+"p�� U>���24���
��ļ+,
�̫yy�?I0��zҶ"r�c���.D��
n��ͫKY�9o���;;|P�;p�o�s��.D��/K��X�ޥ1zD'�r�fJ8#���c�w�v�3����W^��J�IB�Z��Tr���`$�{�-1�&��L���d�ݛb�ՂNq�
ַ��0�?�:����61I�p�+E�Ϊf��*lY@��o��n,P%�<��.��ѷ��|�r �}oO��6����G�I}ػ?�˵��nSwq�O�g渡��3��4㷊��=��������5��2����c�#���w��b2�[iZP��%�m[�=��\��T��y��|�mqҊ�T�����"Y�Oc�eA�497{�փ؀�͸�\�Q���N6S0ˠ�O4�4��H��J�K.�㝤{/�\2x$�Ry��*U��%?|U�������'�+y���x���A@�t��Eq��Ra8�H�/�L�r|�,� )>���O�Y&9�ܨ]мv*�-���@�:�*�����vCR<��j�V�x��qy����O�=�& 1�+��~k%��C��)�|�����~��d\�Ɔ�c���PJ�`�er��VW���-t2>]�d��y�Ķ��`=}��|~�f��4��C޷]l ��y��p���t7.��y���S��to�,�g`8�z�����hK��@�G��I���O6�tԹ��.�!0K^�oy���!��,�̈�۵B��%BN/���^�����I�ܓf�6����"�3v(�rF\膤M�?�3/`<ޯ~`�e�ի$�]�̛<6턥��b���S�M�7���@����-H}X�������J�R��������ȁ �=�A�?��9��� ��m�����H�^���f�}��FuyZ��V%!�m)�_s��DZ�;�^Q<ͳ�|�a�'C.R��ްG.t�h�����4�q�k86w{=����)�
���Y`��X����"���0����U��Fk�$�*cI3gkzJ5�&r��PRŧ#B#�A=('���;��$�����Z�� �$\�"�(3�|�������Ԟ�M��&JtVJ{̉�^5̔>ی�ݽ�Z
i_yG�@���g��݌�qox�6.��K@�eLb�ͦ���('���R�B���]���i7��p����O�@���t�?�J �9a q� ��q���������c�_D��DrٗR��[���:<���rÃs�};��sWL(},e��c������84�Ƣ���NE����x���̻�Ղ$�Y�OeA����j!��-*�Ƞ�lg���/oM�$��Go�V�u$b�~��:R���R�9��h�G�
=�_n&�[9�<�Ў�&"����IKH�wҩH�P�����l3\��(ߤüL\7�B�R!EMr!�:<Ŧ0��Uw�ʶ��!�:����؋l�̴�Qu��K��ٶ���^'�R�ÿ�t�3P���������g?�m��3��}��9B|aS!�����(^�+�@C���S��l��)�NO�Q����K�Ogi<���qru9K8P�_�c�-:�ϕ��v��3p�c�@S�H�k��R�w�;c)Mϟ�T��\@?-O�֊�1��g���p.7}��'bM��2
Lj��:|��U�e�Ę���5H�c��\$w�4h�+�Py���u�;2cnZOM��&��$��i��Ux6�������fMS��vWC$���<�g*q��C���Kv�]
���b��I��/SW���A�jʪ��A�\�TL�����B������L`�/)�ua���WP"+
S=��"�8Q��+��μ����wc���%L�46��1a��,�T/I=R�x��Y\X�M>�u$��E�!�#T���Ӎ�ĳEp��������M�.�'�xP�@�H'8��:4C�d��T<'$�M�q��rv$���ȺX��^H�(�I0������,;��+�?�/8� bU��,�4�Ph��3{$D �BOi\_�Yo�h��J�+v���$���\QSsC�ɤE���*�0�EI�%��c��p�E�A�F--����_��H���Zp����j~���/!�bnU�ČJ��F�>��ԣ��</�?�J�9�s+J.$[z
�GL�.kPS�v��k�8Q��|�Ʊ�ɞ���ͯ �:����_Z��ֳk`M������N`�p�Md�ө�˨��H�[�B/�5�>InM�py���3`<=���T� v����,�!H�|CDXw+`���! ���ٸe��JȘO��+$T/�>�g�ǻ�����e2Y>�p�G��;��bw�\��z�%�-�ҊT�w�.^ҙ�ӣ���k~��f^��f_={�6y��(a�8j`�����_���؅��E6��_̉��R��7��Ɓ^%�ӣX.��/MwIҴoۊ?�a��M�xu�P��O�4I�IK5��$�TV���hC��I�}G�	w-#���\Hy<�0e�����g8��ysz�J�,X�@���l��d�n7( �K�|'��|IS��s!��囸d],��P7���E�n�ߔ ���v��
�L���`�P1����@��ْ2c���o���M0If���;L3�o�N�ｓ=��?�~eQ'���b+�%)g[~����������P�oP� ~�������]R�q-1����螀#���>{�F	���au� `��|Tg���XV��ҁ���Ayi"]����6~�	�aƽ�~��A'8�g���O�J�Ei��:���Q�(z��\�=,\?�h���R����0�7�T�A����<�P�J����5R�
J� � G��o�e���#X*-t�>�Л�\𡟁D�Tt�r8fr�_``Z�p�˶b��K�c��om�û��O�Kc�mE��2���    ��}��X����\ ��,f5�~qo��Z�M�z�6�?P_��U�~1��}�:�ϛ��қ��y ��_1���͑�*���{��T�}�>#��D���@���W/+�t<�惷ݡ�<z��g[+�oB��c2(I��C3�:Cd��~����H�c��Og4�k�1��� ��J����h�L�m�D����;}�m�)ӟ�j���.�5�O��J�F��8E4�1�O:�H-��GkTiT��ӥ9�4��,�t��o�n��1.��+]�p^Vp�r� ��=��Z���"W��cs#���w���v���ޯے��o)/\1'��.��ө�@��|�k���"D��K������~��@���EE�_O����R��I���TA\F�H i�@�?P�Oc���Xp�rW���_�V�璿j7���0�ՠ�BX�Y��Ab 9HpQ����|�2me�!�U{Ec�l��'�ӥwCcak*J��5��\�wӇ&�}ib�
"aZf�ݥƝ(9�2l�]�ce��{.!f�ϥY�w�j9��sv���&��gz�W�y���
[��i� �b��=}�oԘ ������͛�)�r�8��]a�sO��A��_�{�.�#W���/U~��������?��si���w���C_�9~���v�c�%�� �qy��
ӯr�<M�b \�Z�!�nSeV�q2�Ćl>{]��K����;Y�u@�z�sU������Ջ��i�eF];�58y�z�@}�k��QJ~5YL?��8��Ը']�:�!��b�w�ӕ
��l�����D@����5�'j�y[�G�q_{s=cH�%���Ҭ��˦ڐ�M�i����>pnK��J*�Y�[7<����J������l:D��^`w���Y(��TB���2���=�;[W�w��������
��>
~������_� ?�?��_g����a���0���.��]&N/I�&�3礻���#B�[�^L��Z_xL~6��`T��Ur�w�a�d�&ޣO��.?��2O��9�������� ��=�]�r"o��6�	!KLL��o��u�@_G��e�U7��I_����4��e!�!�U�?�6:/����#��v`��M!`;�g��_�3�c�����a,�U�m�!�i�����������&�P>!�nl&$!����y�)��6�t�߮�~G��ڄ-��`i��hB���7�����,��+H}~�Ƀ������_�l�/)���M	�K���7�_6��gS�Nu��b><T����<�2]�]t��#%�OH�	���`���2���S�����[�S���q� ��F��c��.z�|4��L���YrNA/+�𷢫�z曆^}�@{�厩��z&&�nAԴ�=�M��Ly��50��H�5�ʼ�dÚ1��s�֋�L��RT�xcM�'�T8�
�|��Vg-K�b��u m��D����7�l�� H2�we��Z{�ܺu��6)r����1 1��L���e:A���"
�����_:|��O�+�rB�J�(���g2�vŇ�Z%$Ţ��۪��8R0�vh����=}��;��Ω����=h	e7ki��٥�y�s�f���� E/c��OK,	������d�z�,���÷��	S��5�����۪�@�/
'2��7��X�pO"+��E=��;~W�=�f-�,���!����OZ�����(#��S�󡔒����(AҔ�9e����ǂ�8���z&y�;/�6!�#�(q1ܹ�Y�↉���jX��l�7��o���nJ�������W��8��>� ��#�Jk}�l�,[��y"��9U�܄a��)���C�fy���Dx�\D�т�����e{/� ��F,�N*�Y��by9=0ޡf��*Bŕ��5)��ث���c�lϤv�B��g��,MB��zD���\�N!�r���^ְ�����Ҽޢ��e�}'2�;��X��3vql��p�=ܺ=:3�$,Ub)��]z��{�$�ve�9v�I#�hBk8D�ph�����)���*���O\����O3�Q/�ٵ0�� �:[��6�h�정-��O�g�`����2~b���Jx �������}Db�I6��u^����B��[�k�J�iB�}��l^����Yn�)#s��I����I��GV�V��eː�O�m���g>{{�{S�<|�N��+�������U��ut��|{�%iVkּ_�T�ͦb�/�%�UE��VIe�G� ��l�j_��9��/jQ��kٮI��t�AP�X5��E(4�ui�yʭ��Qh�P	t�R��Z��:�������Q?+���� �Y�7XGIs'�Hbn�Jn���*݃�?<g~NԹ	���\�3�H�|2+���u"���@.�L¿^8|Ga_$c��'Bg�b7w3?��8K ��qNX�^R��d�I��J@��6c��|R�m�:���צ��b���:�;�b�� >/no��]�Xwz#��U��	(��׸�vp� ��U[_��i@[��Z�d��KhCj�C�P���C󎌶���#�U֎Ff���ZK<���wb�2���Z�,4��$��0 �ci�TK귞udz%��	�蕗�N\}B[�ܛ����r����l�;m���ҵ��[iȎW���D��V���*�z�e~�j��?�)�_�I��� �?�E���?Ȃ.�8�(������	"�E�R�?&5hX��U���B���	����]�b| "o���=�a�n�C�*��@���J{�d�:Puf�B����]�����k9��PR���d-�<5^��Gc�%T۱ġg���0����[Hs��)�J��B�i���v�LA��&���?`��m�XDQ���Y���u���P��w]�KmNgrՅ�Q�7Խ@�����H�t&�R[�'��f.+��|#1?�UB�[�c�yRp�ѽ���w��#I_���=_&a�1ֳy�>�\݌E��~���?��|~o����p~G|�"�^��+��~�
?�
$L���$�ƾ�����?F��A/�`�1��H�� l��<��j��kkEM��)��u����H���>����]�.�5_�2�{Ģ�h��S�������ex�쁳r�����ϖ������n9�Snj>�-�~�X��8�S�&�:�@��Ш�K��u�H�y��W;��9���J,��8�M���d���2�?��e�LyB��TK\;fh��J��*�n*Z�vǻ��i[�D�d��y/`�m�q32T�����{�16���w��Y�* �����j������zy�_l��x�d��� �b���Cn��qk��[�|����� ����xˋW:�D#�	6.~5WEM@�b����֔_G�l�2t��85ۇ)���"$��DX����=�*]��C_��I
&����&�۰��``�egW|�
%,��LSX��0
+yo�q��fKd�ӵ짱/2��lv��YNŁ�Q��7zM���H|a��G8+v�+��?��<��T��0��@�� Ac�UaP9��yZd`WQ}�N���i���͈�	��ȵ�ڨ����QY�Th�V�N�&ٷV���W,����#��+�Xg�[����ڟ��P觶���k��t��?��+Ƒ�u�&�3����D�,�Ι|����2���RP�s'ż_ˉ
 1x�#�j˦۾R�'�T/m��%���%�<����s�%�C���-�c.­�l�Z��c6n=&���Kۏjb�<L�Q,��2z�T�G��V�g���H��ph���u�!����Kp��s����|��#��W�� ��(YS��*�iX	�h�j�h��grV�'6mQw˽�8�]S�fE����$ʆX���:�� �b�&��������{s���++��G;�W>��_<��W��w�W��e�4�Ӹ����⚾C�E����L1f^#I�A�h~�_{    ml�y�~�`9��+.�B���衟��-h��{�߷�E�a���`��,O��&��H56=�ȱ��{�zP$(��3Pm5��G��ʛ��ϟ�{�ȄAgaLQ���3@���=�ᒈ�H%ҕ�-�IM�&ՙ���'E���u���<�d������z��
$Z�%3�MΰףSQk���G,**ͺ˪#/e�6Ox��⇶�?����>g�5z��9S�N=J�j��1�� �Tj��sGR%���6��5��F��1�����i��� ���X:��N�?���N�F�F��B(~
��P�������L�1z�#�
������1���W٭_AC8B{TEՍ�{�1{�NC�v3���?�^5A�S@XEd"��Ew�YFNl��ߕ��}-�m�^T�2�L�y��1��X��e��u�b�vN����¥�B�~���n�V� >}�Q�Y<�N#(Y%�q�-�V����2|�����
�xd1<�`_;^����\"�Xb^�+E�O9+�0?��v������d�g��L?I�3�T����E�^�xh����_����e�?)��J��~���B�?T��9x
V�h����� ��D5��V|*�`r},O�u�����0�@��a�.ux\zX:
����'H��2�C���_E����L�N��S��V[u��2���������mi�_��%�=��]X� /%��"&��,�l�q��BQ5��ҍ�Qe됋���./��Qg�H!����HE�������
�ͳ1����r�ᗤr6#�>6���&OVkX�?�Vl-X-��	�G���� gS�R�\w�E���<N�];�|��|a(��|�.��̷��M���	�l[8���O!z���2gWI^���������ݵvY�<����9��G�-�_�i'�ד稀

e���KDO��I��E6���D�C}d"�M ��������D�Km�������a�+��݂/���X�%��iD������Za�!]��ۻ �Vs�p���{�.:�P����G		}��+k�h�2#d{4*��#`KK��k_c)O��0��B�� LzJ�¤YjK��Q_��ϊ.�K����9t��g7��+E�L/�����?�9H�_=H��P���"��w8ng�@Mb:��0Q2���k����06/߬�-, j)s�;�c�eb+H�a������Q4�^Lyg���?!�i��{4�mJW��ψ��|�`^��j"o�(i!/��6���=���[؅W�+��Y��țl ��@�@�$�S��tV�6�Ʒ����v�s�s�w*�#�h�!73G�qc`��j_�p�=�OB���TM����u�{O>�ȁ
An=��W�ðg`��@}'[����I ���*a���F�"�o�"�A�A���C�[&�{EY]����6z�ٲ���b&�yD�(Vꢾ}��Y9�J:$��������5]���r-�[��{�k.�x1�t��)2	�`g?F��j����|¡a�S\BɨJ����8o�i_aq�ҍ�SƖnb�!S{��!��u�"���=	����|ܓ�0���א�C2hIs��B�(����w����V��RK�����g�}n���2c��X)���	�a�Tl��lʫf:#�U��=4�H��;�KKc�U��PN�!\���ŕ��8,H������w�M��Q��w�������L��"e�����f�(D�E'�9�ǭ[���1d+��~L����Q�R#:Q�]�m2�Hk�L�82kq����Q���R�@�4rJ���燢���t�.�'3Ncw��ɰb>�*�fh�4�u��奷�-|��n~�=�'���Xk=�r0q�T0�~�E�V��:Ol�I��<0d!*����5]]&�g����B��L�wF��ج����5Pi0��l���w��cdt�
�s�%���Pdq��B��Hn���lѝ� #��d1@�e?��#fr`���nL ���wf�����E �~
�o��A0|��d�P�[����J�VM�� B��U�4�����8AK��O� �03�r�fJ4q,��s��4�Ш�/E�A��
�s3��%Wi�\�C�#�������	O5o�tǠ��+������Wz���a�5��I��#�cHe�m���0�]�����[?3��f���1�	u�K�#02�U�_f񧪰�d+����Q>t��G!���&�h���ڛ�:KA�y��dW�"+2@�U"�Sƀ��W%�Z葋�ѱxa���U{q�9�,��/��f0�����wpyn����dX��eLa}�^(,�����a�-�Ṟ�isHx���׮MRx*u�=�Ξo	L�oI�X
�K�0���E9t�+!@H�J�j]��f6���@�����)(�f�M+lA`U0jT�X23	V�:b����1(	F����dI��Z����۱��B���<RG�9��ayS ��R�د��OZBZ��{5�VԊsC2ƶpSm(�D}�c�A��`@����S������7�U#�P6�*�l~6{����Ó� f�T-�e�[�������׉��q��&��Է�l�Y1��@�O���T�FG�)��0,��4}�|�e�d��U��e�v������7;������wN�oݥ��.�Zx\��2��E�ޗ X����gt��bK52�\4-B;4<T�F*�o��>�m���;b��8]��+pLD�T�x���w��щ2�nޠ^Rm�~�:/%��٪4/�3�����`�4�
w��5����gW��`��'�R����:���ח����2R�W�
)��`��9a��K��{����ߌ�/I���wLE3.|)�9!���մ�3C�L����=��ZI7�h�0b����zC2�B܎Rn�*%B���Yv���H��2�Ѣ=�Z�GMV���e�\)d#�'>�7�u����Kj��V�Ax��5)-53tk(��n,�� #� ~�El���#J#���$G����0��=��]���G�^�8�O�h_��ʔ���M�������t��6�G^C.�H�����<"e�	���2��zC��հ�-��=���ԖF~B��F��Ȁ�Qg)<\}������ȯ�w�\-����Or�Q���ѕ���-�z
��o��1%��O��#Y:{�Y��VJl�<d��	�L̾X�m���(�$�@�`�J�� ����Z܀`�o�B�"?�Ⱥ�<U�N蓬c]���\��|�&xW�d�09��.D|hH$��ɔ{�#����ȱ�|��"iًC��m�}��NBO95%T�3,�Y���<�*]|3��w���]e��R�����]�N�>�9��WJ�~��+FD��\R�'(�̗����(1:(M��qtv�_��9 �_% �eޭ�C�}a<Z����Eէw;ӹ+�/A��=*N�D�,�4�{;������LV�m(��ȣ(�8��1vԘ�p�f����=�v�yȽS�+��Ĺ0Ō�A��P��dY���2�{$����z-4�<�t���	VG߬�54���!L^��P�`�o�oZP?Y
T���9�X�'\�U����@6:X!���oW>p~��h"ڤY����~��+(Mz�O1�f@o$}|��AP��n�g��M��cƻ���<fZ7i}SN������'#Wo���	��_'��?�w�^�`^�p����	r�$��g`)#��9���')�c����rZ��*B�{��tz\�|�M�^J��?��R�טꬹ3��B�1��ܨ#ݘC���7������
�y��4`����F�V�;8u�z�_b�\��Pײ���6J���L��0�{X��yo�۽A�uw��}�w}>��i�}�4��`�3��,�R��V \(<�XN*(�`�b0r������+��W��p�l��a��
�Ή��(HTO� �~�Y�����x����93,��%�O������Eo8��u�?�-db��(�/��Fq�RC���47>��    Lݑ�+aS���3A�S��i�H��ۻ0��l{Dn�|�Tʮ�櫽b�s�#\ޘ\1SO�
���"�t���pq���J�%zW!iͳ�1��!T�P�x�����ˉ1K����NK:m��Uگ��*)�p��Y>��g�6xd�ǅ�����Y��g��åXO\�h0��d�,���?��~�ə��VQ_�,�B�t��3�	��Yo	�\���i��1;�걢�]�C~E�TY�I{���>�g�������i�\|�� ��P
!�e�g5�ub���m�d�=�9��[��X���>����M�[�{�xlW?Nb�L(oirFA�)�5��Z.1 ���U��qʏ��Ѓ}Ua=XqD"�#M�q
�Ju���Z�ě�U!QU$�Q�}~2��]��7�D�&�(�:x���:��S����2�+�	-������u+����/�^�s�$�A���ӋnSfj�˾@���fgU�����ӫ��f"���s��̧�/%%���Kz�����=~t������b�$��о7�/n:�k3�������6����i8 �O!����o� ��j1GN�����n���Ʉ�Z�M_�7=����2���<���i��J�����Э(��Зv �|�yo9�'S����j3=\^)0�.h��@�1��-2�-۵V��Jf�GӸ�6�&���s�o�O�H�fK|>��	3{>zђ���X9e6�'��F𭯗S�Y�Z6�BcY�+�c:
x�G�_7ȕ0��ji0�j�{��7��wa��.��QA��)^�J2~w��8�&J�4��8W��Ɋ��L㉭� �1GKI������`����~}����R����O�mrE9�Xw�YE�݆��cW�쩻�ȫkn�@��{nCBZph)�
V	zB�6E��#(��4��<g�'��(S�����-�	�L
I�;i$;;����8ɹ�mA����/�`�f���_P�UDH�`�Yw��?ȯ�L��`����@� β�OʕN1�(���}�d�y��Jo�p�}^NV���a(o�8]g��"��	��!�[k8�Y#.� �K
�[�T�b��ϼop��a*��Y�1��Vl�*�p	�f<~q�7��_��c?@@���@��s`ЯJ"�[�jB�Ʋ��/����#��ec^C�r�Ek��/�]T��Y��%0����h6���]���y�rS<��K�c�\�9Eu)��'�\�<�UOs�7Ã8�;>ۅ��5�}�u��v���U�%��C���Α�����)�y�\R�3�ސ�Ązyi��.���}J�����?����,����$��6�\��R�ʨ]0
�ZE6$�� .������hς��AS7��^�Y`?��<�<�B�x���2ڗ����"Mjh �-oȤǵz��?\"GG~i��@~��A|�B��:��Y7�>qu���e�8��aﲮ�T�ѕ׏�}��i��a}��S����&�Q��ѯ�|V���{�j4��۝�˱�um���S��J9[n>���Ĕ�p92.&6m�h�BL���(I��w��;���__��%��-9pz����Ȗ���3����?W8Y#��Gaz�SR������p�׺��y�*�g����G?HWtP����U��H�G+�5��D�&O=A>��0�Ĉ��xZ|�ݯ���Íi2��c��.wt͗� ���ZH��t�Ta[s��9엦?5���[C�Y
��?�7� �R�*`8���wmb+��0̾����./��z�����5����t���>|��<J�B(�׷Sl����^�n�;�}^+��Yx%����������{5s�7��!lvn9���-���!Dв���Y�eљ��t�I��9�r��`Է�yK�?G�*���|)c�˩B�n]�W�����z�ONom$U%C� ��Xed��@��{�|��G˴�_Y��o��[]����W ��CJ��mP�Y��O`5R�� 
�~(D<��L��j����rP�Wa��w�:�p4"�"E�YM�!�jh{R|�=�t�vӟS����yղUQ����b'��
-�{��7�qY�hY	fpU@D�.7�ؕXC���н�Z�c�Ws�ݩ���I �CΘfg�>��J3�D���{�����a}�mM��Ũ�*8;��3���K��ء�����:�ȫx֡�y�+���Y(�U���4lU׻���T'ֲ��U��Y�/h���θqe�2������(� �Pl���BPԑ��;6h���/!×#M�_Z���g<�ssG�N~��i퓃���9П�)�"���Z�2&� �5&C�O��O���������hn��^�lf��<a�h���Ð�����	��"����z�t�dgFŞ�e�H�����<0�� ��4Ӷ\��OD������$��jJ,�Em�K��#Y/�d���Cgvzv��W�9�I���.H>��F�� �58$�*$	ج���%�7 %�*�s��C�O��z�Kt�Go���^���i�Cj+G<=�Ԛ52n��0M{�ᅯE;��yk�GCi��d��(��zf���0���?�s�k�U�?�5�{)<��"5m��;���� 	�c/��n��-���6Vo�4��m�N+���Ć��3�5J�w���x�/�fϭ�c�JG^�y�k=6\��p��p��|�Jo�F�����"83��<�	b��^��E�`^�^�G� ���~yƞ���|�a�d5m�d)F�� ���%��SP�׶(��O�V׻t�B���P��g�O�Jw���������AQ{����WEI2��p��ڨ-�Y�6�"C���!�.��n�J7U��9���O�?7{�Wa��B�I�h:�G�t��!.?�ǉ���p��5��I�I����R��UT��q}������1h�Y˟��H�������Ӈű*M�ﹲ�����a��ꏾ�K�Y�G��o�6��ێ���]��;jD$���8�S)�Y[Ø]�j��ǝ�F��>�~�8�oh$�XЉM�O�;s=��g�~��9�]�5���[v�3�g�.��0|�al_����}s�gg�¥��:�7���'��SEB1��a����r��6�Ӯ�-n�s����`������P%~Z���z��V������ߒ�'�#�+��L]{.�d�8�N���=[y��2Tղ�)�ҏ��ґ�H�[�|R&5JZ��Z�7�ӂ�F'�Gq5���!�E|~8�p���l���]P��RtO�����������[��e���"B��.��,v�v|�!��E scك�	�V��Y�/�zg��hM�y�&	6�L��h�L��'����O�3B@�tmH��O&l�B�h�*3|��2�5V��:��Zq:ϖ�Q�A�Ɂ�_�YT-�i9�V}j�L�V�[�g�C��1�V��/No���(��X(��*�ߡ1�t����@y��y���aa6Jۨw���_�	x:��2dJ��$���7Oi�b[�����1�/��O���K��� ���|�_�o*�Ж���nL��z�6͟������E]���#e��ʒ�eIŀ���s'�	�$��7�/x��e����jH�U��i;Ǻ��xQS�،o	w�\���U@IT�����&�qC�� ��w��1�V�.i���vҰ�YO!������h��S�Gݛ��X������*xTR�}�"�uV�O�!/��wI����P�~UP����[g�?�قa0�������o����F
�����N���Lh{n���g��\Q���\O3�su��k^���C���/�<}���� �b��\T�����1grZV4���*r��-O�`���m��8?n9$g~�VVR+-���63Qq����|`��#7�ȑÜ�!J�g��4���x�/!S${W���M̋�F�)ArN�R�%5	���YMC��Gr�쪇�I�X���M����Mp��X�����i!Ck���8˨iF*J�� O
������I���    j�!�6�Uį80�w��B���W �;��@�tn��9���{߈��ǭ+�P�B&�� �i�}�;�Rl�^���th�	:Dt"8?�f��I���轐
z�ωe� �n�4�֞����S@LBL��>�@W��ܦ ����̚|�!d���mՃA[��B��Cd��=O4l�v������X*�Cp����i,p���rs�G{!�.�(>�t6�Da�0�0R�e~d��=��(��) �"�1C�r~��N�����18*Ơ�py��,�m����݃{���k�Ƅ(�Q����x؃S�#!�w4�'B�2��v�����?e�`�A���=����f���0{���:?v `?��#�Y�D�L>�ҭO��e�5�c�~^���O�O,��O�O����_��(�����,���s�ώ@u��F�H
��ӕ'ǲq�y�v���Ò��'�E��Kqw!�m;�È`��H���u.�N|<�q9�٘���6(�cٻ��9��mI�͵kL9rW�(�� >L~�0mfa��_��4M/|bsB���s��r���-��ī�ՎJhJ�j�]W�� d-��j�@畵X��;�v
�[؄�2g!4��P(��Uߑ���@]��c�jy��b�}�#�Љ�Վ*��	��F���lD(��J%r���E|�ќ����r��&),~f^��?����?f��_���������;� �Rň�����(��=�|^����vƁ.�4�Xm����l���Ȳ���d�"7"st��Jb�'_�=(�'�Y����5WƳ�\#���m�녀�8�� �d��]�x5������:�E��K����I��`��$��\W�|�Y�5��:�����ߏ��2%O>�i�e愂�Iӧ�����<P���z��������d�@J;��Y@�dїZi�+Rv�l�I<���O"�z>�P�V�� ݓf����F2o�8� �u(s�P��Br�&[q��GCc���I�Z���e�����t�?����B�s���	*�Q]*�W��tg"ٻّߙ�Ma,Dz['��h<w�sx��u��k�&E8�jC�O��|Ĕᢑ ��zڮ����%V���w�09�6)f�#�Z��Z���\6̱e���E�Ch'�i6���E�}�S�]�����U���8Ɨsi�Ҋ�MjU���_��@�
�}��	�����d,����Bq�x=�G`���b>��<rb[�b� ���
��9�����|�?���T�Ҩ���F)=��^0Z��E�z!�Q����VJ��P�?�?�Q�ğ�
��	*�y�߼��߫ ��������UO�5�:b�bx �F�WP���$��,��)&՜��F1u����{�y��A��t�psQ�d�Θw�����$\�d����6+�T/�����;Bf:L��T������l#��'�h�.���[�n��Q�������4ٌ��9�q���ak��BW�ft�a㉁xRǡ����9tu��,�@��f����Y�1���=���T�����V��z������j�ƌ�K��}G�r�z2H#2�7Km~q�5���
���՝h��
�g�*�� �7̷�8dvƋE�X}çv�!�(��K������}�ј>Oh���j<Y_����!�Jᓔ�Z*�A�:�!��2��s�y[A���[�?�p6�(v)f��L/J�*�+[.�������3�^D�#K���z�������A{RE/�U{��������{��XgN�@s�v,�}4��j�S��������(D�ëWȹi��`ҧp��Z�ѵԱ0A�C�~e�$<��]p�B�ZcF�'��XO�@�2i�<t.�ޟ��Gϯ���|C8��Y��T�p�7���� �7@���e��F����n��@zS��q�3�v��>޾���ڴ����@2cj�tZ>�r��;r+\	I����?y����Dy��|"2�=�#:��7)���"E�ݩ��v ʣ����zSA�4A���~�n�T�K<̶�A;���'�l�4���F��᪕�,ĭ���Rn]��w!(C��nƾq�P��u$uԫ�~1�{)ٴ/��Ꟍ􀋁)	f�^��h���xU�~�_c��(r<�Q�� ���2�~я�J(%M7���r��T��Mj8�����\ܤP�Q��!(�$-(�/KJ�4ѿw���-d��t)��?`��?�@	-~�t
��s
���"2l�㏛�!��;ȶ�]U��H/h��vk�!��'{%~�٫������0�f��WxK�$��7�Z��&0��g�U�F�#ٱ�rܦLTE�_
��m���<b6�-� �Dׯ��X!��L��u�[!��yư1�`Z�-Š�I�G,R�೥� E�:Ľ�B���X��ӕfx�"9t�0�`<���ʬ�<�T�K:�8k�I�����;,C=���>>y�f�oGʻ`����iC�L8Z\]5Y�AJ�}�������krU{Kpy#�>_8N���f�[ x/�#�����o��O��A�'�����X~�������1���k�����gO��wd��t[�E�����z��AdsR���:�A�'�&y/�!���=	
7�u�6k�o�a�J�i|R;�]�_��9Z7��5���zU�s�Y��J8�s��Y�ga{�/���]YrӁUk�A�ז��7�]��_�9܇��`}�9�Лy�mEs�a���5��Ǿ~�йE�͛�������o��-ik�r���8���+���Te'�寉	��ڐ�~��ѳZ��^�p�P�`�oF/f��h���A�l5 �äى�6[��>�Í�U�^�����sX����|�o>��3�_�����&!'����x߼��/��Q�b�^D@����:�?�=�Υ/țys�H�b���ʉ[�w6���3.AvWk)bZ�[3a�ON_ׁ≡�:mT�J9;`?���}Ʉ�����ӹ�j�1��s*o=�+�m���.j,4s^�u-,]����Wݕe�U����3��Jm�t�; ZT�$�M$ST��@��%��Ȫ�=���8	s�,9� �����b,��Oo{ĭ��E���{���z��T>��Ggs��g�й���<뿓r�݁A��j��I�6���9]���v�P�tM߀�<�~��ßo#I���)&�P��C���L;ɸ�MٲM0Q�W�x��}+��6t�h����|�f_waEe]����D�nck�ՈZ�f���/gIz	h�-N{���\��M=Y�?Y��*�8��J�hlҟO����������j��)���IXO�)6ϴ��}��Y3�Q�%��ڪ��u`2�jY���ôz�����h����>�.�%�ݪ^��Ԡ���r�湶��*��^P{�g<c� �l.�NP���+�bFV��l>yc�@��X��7�Ć���h��Y��?�����gv�C��"~ ��) ��/�' @@��2,��/�;��]e״˙ډ������)�a�q>��[��G$w�'��#�W,�8
/�x�D ���u��<�~�ҳv�:���U��k�u�&�{�w�HG�96++J�S�j�{�H��VW�;�H<,���P D��;��mD��dQd6��G�:I��[��ȪaC�y֤;B~/��DfI��N�;�Z7�t������<_��  *�ZN=�wC�@Q�r�a.�"7�Wm�����	��[I@Y:�{Kef���Qǲ��"����<w'O/��/�#0>���-�c�����U3z�o7�iޟ:�=�*��w�}S{DY���Jj�xQBfV��aA�\�t���"���&5NԌMSz�w#9�ai�'E����?a~Bg�C���Duc����مx>*����Ҭ�i��
i8ON�3�-��X�{̰8�����zU���)QE!�u�nn]��{�)1ѓ<lL��mc�_<���[[X�{�o��A��jQ��.&��[��P<	+ iH�rSb�;�$��w�L���Q)p���N�i��\gb���b�MA@�L��$���@�~�;Я����|�?�G    ��ߣ�V�����	��{�t������� ������8�rZ(5�N�;K�,r��9��EN%��0ެ~�u�꭫8��0/"'(}㋬b\M��Խ�%1~�=Ql{&���o}�������ރ���YZ�((��=���hZι���q���tݔ��U�0�n�5C� '��&�^	R�r;�C�Jb��6�K��0�q��i�;r�G�,�U���,{�Z,)�Zk�©�ө/0G�K��.6�EfVgU#��� ~�*�@��g�=c������� PȨ�I��ӯg�Dg���oG�Y�C3�F�3)����;]�M��;=�gZ �)�%Kn�m�g����t-A�	E���&~�p��VL���æȩ�@�y��ԩ����Ő鸦��^~�!ǩo9���=�8W8��t�)H�!p�Fvx��h�K��t_�)�w��/̇�/}ps�܄C�]���^�D#ܗ����A�G�IJ�/b.���ό � �tb�0ѕګN8$��S���*�\��n�Hh�j��b5ˋ}P�|��H��cJ�ġ&2�f��d��ذ�܍��ۮ[��@���R��7�h<ŭ�ȧ��{J�Q�W�_�
��t)���6?�0��}�q���O��V�`w���M�KOg
��([Ո��B���Љj����W�������~���>v��_�ߗE�z�Wk��4�-D�+^���
Oi���y ��F^9��'�i@-�լ�F֊GO���nN^�[L��"�������NᑉMq(�؁Q����R�3h� �h�M謲b����X>�x��x��f�j���Hb	=�����N� ���y'�����fG̖��%��U���,��{�8�i�P�A�	BI(����Q&�����A8�s�N�f���"��.����c��}�\�Y�[@�����s�>���<�Q��J����Z�y�,l���yʍ�\�����
Z�ޕ�@�� ���#�l"���E��o��^�ý\_taT�Ν�G�w_�9�2���]���B��'�F���q?����$�
�넏����B6�}��2��	���D��-O�OY��C!^���6�/�c[�K(=�+���V�t7�����:��ޑMML�)r{ウ)�F��� �PE�uGs���Xsv3������v`�VkN��V���2���osuM
��a���l&=n�D�0�X�HusB�H#��\܇�$�%`��C�pt9��#X��3 �?;��U}S���!��l��lu��[�ˌ>/�pP��Qc���X�3�|���^�T��_}8*��y�5����6P�I��M�<�3���!� ��J:�5�g��׃nT~ڒ@&6O~G�ܡ�;�Д�:�Q?y�MpL0��ۍ��f��`~��d����T���L����K�+�L��БI-��IJ^��T���Bve��@;�JSz�-3ޛק��nbd&(n��㜖���X�'�+�g�4RZy�$���#n��Z��'��qf�O��\1j�>���qz��?%�ߡ��P�|�Z���3�� �6*k~"α�ܳs����ry��A�iI��,Y�n���G���7��A[.v;;�=�T��ij�x�r�XM��n��5mN�� �qC�g�6�BC�?��	%/��&Hf:	!ͺN��S^�����A/� ��E�CYd���������Whfz/N��ܴ�+잀���/R H�Cf[�<mn���P��6��臱Sd%8^2rv������1<Y�U'v�5����T�IF1�YS58Ǳ��0��R�P��z����ǂ�����#m=a�B�Xr�-�a%0{�Ãv(�E��|o7!rΗGB����=ņ�$�V�el�+�� e5h{�o��D6R�-A���r�=xKxT�.����U��R'���jh�O0��v��]��x�[�>M.� v�O���׉�R4�ۗ���~��8��v6z��݂G�h��oQ�[Hv%�J�9�M�_��=����r��'��K��\��k+�&?I�s	2:�|!n�cYD��!L��I����'GY��S<�̈Ї��ARz<�
r�
����}�~�`�w��B�r�?�'Cyo��,��,2��ؐIS8RN��(�����2�B�<��	�*�����T�@U�	�\
�I���l=����6���u����)5*>EgM!�+��J�vQ��@�3%���(&�|��q�_a��	�%�؋׉a��u3�B����2��^i�y�!J�*���q]�z x���;�+!P��Q�|��b�0�n� W+����;~7�E���w"XnH�-tA#3�f�4D͖��/���ƪ\�y�7'��4� Ҽ`KU���d$�����C��;:�,�q�T�ك\�iz��Zz� �~E(�oa���|9�USIt���	���\S���-@$kjyb��G���f'ʼ�K�~h������'�D@�QF�{lOyi'����_"��FC�ڡ�q�Y�n����e ����_7�8������ͷ-X9�U���k�8:�K��۞���ɡ�j��j�b��?�5]�c3C%��Y��:�U��4%�5�w�`ܧH�ٮV�e����8���36�Ktp.�vԍ�5�2U�L>`���G�ៃ�o�A��-'��!�J���5�%�2�6����=������+@s�]�f�$�;&�s�	3�e�<�:��O�?�`�u�A>&9O������GV[Rĵ}1˙o@���A:6�XX��?`]��?,(��Pc����{���xո��J�����`��GL�ePN/Զgn$2�0�fBZ��B�?�Z��R 'f4�X,d�%�+7PLϬ��ھV��i�~	���L�2��]��I�#Xk���|��ޑn�=?�Y%/���vPNI��ϡ��	�7����bM� 쒺�f�e�)���XC8��aI��H@�c� |n����4A=N�"�1��~6�������t?�bV����M��+�g,�-X�+��O��;:�L�]�w�X]*["�
`A��Tȑ&3Z��f\�<<����j�Ͱ���e�`���l
3O@g/Q�Be�b�Q�L٤'�-��ޫ� k�E4��LI�?��0�cQ0�f{JS�E$(�!
o�i@樵։�`��7�?�|�X�י�hZ��>R��˖lXN��	�(�~��}r��c��A��V��EY#��Vgq�),.霆I�	�s��q��,,)��梇�ڰ(~���s��܎�'�����=T�O<��Ȉ*�Ȅ�9S:D0��z�,�F�$����4��H�yV�D~�|��B�������!�ڭ�g�d:&�]�L'[�~�	��ě����!Mߋ���崞ʷ5��sf��x��"���E#L���W����4�}��`����^����-kJ���wB˜����<j�������\*�l��״�hc
��*
t.��:���CJ�@b5|6_�[��c�P^F�h��]�j�s�j�;��_=i�f�:�����{�wP�@�.���-r��l�s�����&�ڦ��w��;�`��]��Y��[�W8ޫi�2.�o�+���0�{��Q`�2q����D��#(�!�楜6!/x�ƃ��^X��4�v�t;�C�6	_=� �{5��r��&ͅN���1
J�Yz����b`��9
夣]%m�m��=�L��Ț9��|�;Ք�<�E	��������+��m�.��@�:,ŧ�T^G����H��9N+Sn�o�6R�0�G���G��"sߠ�椾�V]|�o�`Y#�H�u�:��"�2T�]"����G#��F�-�!5�]���^!�5�A?=�N�oAO!�g��:*�������Y0�{J��4��*��r���~�|�i3x�"��<���7�+U��̥�[$���N�ad-|������4�{��|w�V�`�Hyt����l���������7��X*�ƲF�U�jFF*�p��g�j�Cp,j���;�P�=u��E��l�H�Y��m����Բ��V��]� �  t�5�ΰ��J����(l���r��/�� GZ�f��>e�� �x��3��/2�| �UT�I�a�>:y��Q i#~�
3�>��e1�عP�iYd�ӱ)��2}�ȍPY�u����^&g*�
�k����(��;��4v�\Q�>(���c�#Y��ыW��CŻ�`�W3��4-�7=aS`����������<�y`��Z�1mҲ�qη�:�p�^��1���$�5w���(���e	��
K�`=���u�	B���b7đ���<%����]rd��&&+�7U䌿�B�j��W��������J��o�,h�+�J���G��ӧ�E�񍩁%e��P�j�O[U'P���u�Y�Bу�R�jq�yE>��o��vm	a�D!�c޿�m�ς��5���_��<�����O�����``��o�=A�w���|gV?��\��K4���NH���9%Z"�I>�\2�{�*ēYu����"��>��L���2��zC"f�c�z_�Qػ_Zq�q@�d�.,<�����A�"*z��z&�,��Ã�*��}$Kk�!\�^��$�%����������ȭ\�S31
[_�q��ܔ$�-�h�n=~�K϶{���Y�^ۙ\hR�*�'�*!\)'��BB2�V�MR㸅�T�rE���A�[6�� �-�Ǹ��>@�_�+��P?@���@y�<p��3q��zV^.r��vf�P��#~���j�k�M�}d4M�x5��<��%��p^�.O�X����7�;��,��4��r0J��٣Wh��'�ȹ�xN;��3�l�3t�����O��C�^�u�3"�v&�.�=�K@��7喻��Q�@� ����^��r�kSV����ZS�C�S�hܜ"`k�'�9��3��f Ɵ<�_��$�����c$��+7��Z[�뙌j��ɺ�m|��Y���w��r��H��5�x��0H0�O(�����������ɢ/      {   2   x�3��K-�,�2�
�y)
9�I�99�)@AN��� .)rc���� c�      }   Q  x��W�n#�]�|�5/bD�~T?Ȭ4�xF�cQ��lJ�T����dc ���&��H��H�H~ �	9��I�h �lV�{��sϽ�z��;�H���T4/S+�g���O:�+��Ɓ?\{$Ϗ�ƚY�ϭ�q˳|a	ߵ�5{��}��R����C:��ɏ�JTa�QV�&2��L�i��u�B�7���ȅL���ǿӼ�ۧ%���^?������6�OK,��;z[�I2Kt�[R�NU��J����~��O5�e&�f�@�St�
���t�;
���u��FW��w���Z�$�;|r��㏽ȎD�G#NG�߁�� ��{|�粡 t����>�C7"7��� ���}`m�`��G�l|L�G������L���l�p�=�M/[j��m&s� � q��ӕ,$��a�^}����˪�m:鰿S����ҍ�t*m�G���O�*��M�7�.�*�-��?�wg������n�g��-���>�X�i��s��t�����)��BxY)��S���ݑ�R���
�u8� ]��b� d�����TT�E	|ʢ�\��`.��e�h�X��#�kӤ�E"��K�M��o=�N-��E�H�n��-l�J���K3NLSg�Ќ)�1�sYq�0��l�𜞲"��0v\����z�:�C:y֤�d��ڶ ���pz8�`�>���}��j��9%j&�Z�5ʒVʔ��aL�0�*�W�c١���#��hHx1�з��D~��G�EM�2oSz	����	&�����2Qm֥��4yv�RS%eQ��~[g�����1���+�7���AV�\�E[�9��Ӳ�妞Xo.Q	]骧%x�'H���֩�ae!9{]�$��Ҭ3}7mֲoP��"֙���fYt�>�J���+M�N��S6�5�̲�6m�.|!s�Yf��#�����W?C��kUs��ȼ���H���Ι��0�]����m��!̻�%s�����| N	�f���&�f�_?�6��CH����:-kE�C�e6��N( ��Ŷ�i�F�˷'�G�G49>?�8=����>�U*Q�yרR4��m���X؎xb+�#gX;ᐙ�zݪ�6�!
l?e��Y4b��JcRd��)���|\~���E�!�^~�B���x�3&��*ONe��q�����}1��#4�M����Y�0��2�:��Tͭ	@gm��6Xs�����.7A���!���Y�3���j�~29dr�*3|LQ",*�9^��=w������$���D�7�u��o!�������ɏ�����F�xҨ:�`s��A,�$Z�!��2QSE.�>6}�p��Cz)��j?To,Bۉ�QoCAm�&Xp&[/Q
7)7p4�>D��PS��\׍F�m�[4l��[���&�-֠���\�͍�v�t0�R:��fŸ*:�Ӡ��=�\��7m"
�S�,/>���	��5�b62>]�9�,�s�d���:N����4��,|B��"J�YP6hp��ET�>	�,V�fC�6�;,�`���=�����]^_|�Q��.����1�r5GJY�A�,1ۙ$`�\�ʊ1���ϟLH����n� %~j�SM�Y�l��a�A��w��FDC�b���������Ƀg��m _��=������c��p87������s:����8Ր�}�̎����h�D��S���u�]���0P��{B4�:=���էej��I��|����+����;䳂��.:W�T��#(�Ny۹��bc\i�MfF��"��2��fڦ�Q��,�25�'�;if��5Xc>BP�F�^�,�p� �f���@�� �hB�g�P@⟖�������j9Z�.8?�|7����A
�KT��������ƽ&�q�q�xv��L&�g��՟��OC�N0�uM���Y{0���q����;_Z[�5�c��h.�TbȲ~��g��o��e8�k��(�D^&$b�����?�����W)�@�1H��׉�=!RV9��Jf@�.9�]�P�Bڑ��-з��R�E�;��!�s�^��7&��|h1����Y�w����/�/.G�         �  x�-�M��6��������э��� �� ���i��%5 _`n_a���;��ʣ3��0E�,�"��^�J�(���2�Q�$�,�O�k�����%E�b1��|�Q��Q�I%G�c�X(���m9Q"*��ÇuR!���x����Η��c@K��;ۈ�AK��n��b����Ť�e׎b2�r���� zS�n?x��ѶS�f���M����x�8=�ΞZ+�=�I�V�r�c���zWK���[=͗�,q
z�'�vLZ��8�羱�s}�-���'�n��%.A/����?W����x����iI���$�I�$�A��w��J��ֵ��$�?�A�vl%�@��ӑ!$9h���� ��뎝%)A+��:V�VL@Ӫ���4�/���Ъ��c:�:�wO��v��)h��a����XS��HC<���
��%-@k�{^'-A�q>�\^��#e�K��+�̀�����%�A_Y�%���_S�F�MƑe��C�������uݻd%hc?����֍�{����kt�܀^�nO��<��n2�'��?�X��ΆIA���H���d��9�[wz��:�6����-�!�?�@K��#."�ѹ�����1h��c:A��<�C��d��,2Ђ�;��9�33��(@ߴ�>��%��q��v�.heC���k���TKi@O��iW�߿���\K      �      x�U�]n�<���U�X$u��JlH��
`��gv0W��a��̾�SE�y?`Pu,�ğ��&U<O�����?������N��˯_˰L�nS�^���4\|�=v����q���M��߹���K���&	�o��r����aSl37�����wS6L��_�qS�)�pY^�����q]��t�iæ��������;m��T>=��I��\��opc	��O�����~���<l�-p���nS\�i�o���z�swٔ�����^hnS֠˂�y���ȱ�~�R0�ꎨ������mS& oxݔ�����i�M���p������C�u�<4U%���Gޠ�A��K�&����~�x�k�������5.�@\���0~��z�Vdַ�D�;w����F�ٝ�y-^��e��h����g���u�T��5�c]21u���,����3�� �w঎\����{w9��M�r��3�]�Vx�tæ)������҃K�����?���0�MSa�������s����AM��o�_ϧM��ܢ)�D�l���S7\�i����x9�6a+x��ό�&����ݍ��	P�y<���߄:������-�˰	��~<���Ѕ���otp��Cc��g�ƭ����s�D��w�cw�6QT��]���be��{�F���_��t�����ҹ�6Q���ӣ(��q<hEz?��E�]�ޗi�M�$J^#�0�ҿ?���V����:��]���Ȟf�M��"}=�̑M�3X6���؝����G�2E]~���c�Q٤�E]��r�
��o�-�c��dn�ϓ&�qa������6���V,0m�Ɨ�̞V,�3���6N�r��ٴ�1,�qy�Q"���x�[1a�w�̤؊��O�b[>���u~Z�~+�}�!?��A����נ��������:��mX��e$ �����˼����n�ZZ������e��ԉ���'M�S� ,o�����SO;��V.��g�X�ۧ�$'���T��[k�KǠ�a���6
��̎nb�R�.���50J��Y,��t��*^'���*�l��Ͱ��e��κ�5O;/Qh���m�"*pѲ\?��ু�n�_��6�MNG�����\�w-�°e/\౱�X�C-C�����g���×8m �ػ���S/!45&�dY4��̞�κhztk?��vƇ����fP��1�"�9�����,�bV�A��F��&63}��Uน0L��O�W�$�\���
|x�0���8q����g(�	�#�໯ZX*Y��?_��N���Õ3O���O^H�O�;<y!AgJy
�̅��J�
�y���o�ϣc:��]�����=��ً_g=h�Ǘ�����-�Q���L�|g�w�@/��zz<9-����t����J��M��M�L��~/��P�B�����0�h������M�_<Զ��-L�/��������,�o�*�<+���@jk,AtOa)dy���&�ʰ��A^[-�f�}����M0)4�x|�|~������N���]	28~W��'�y��������Ѯ
�_X@'�+�����(N�> �<�X���o�|w�^�K-���Cft�
��V�r��p�t��׍Yʭ	�>�蕷.��h�^&�z,jXL�+�n1Q�
�WT\n��z���hG�w-Q !�o_V"�Ȼoη���.��p]��g��
؁7+G�h�w��Cc>���
���{��0�{�]����E��
]��nW�Q��2�˔�&@(y�j��q]G%�>���p�#�Ng ��R�8-�I� �H?	B:OJJ�c$�x���]���N��h�
i�J�E{�$�d��Mq�Z�ݙ5�A�THZg���|�d�/��r;�60	�]�\�l�ĥ�"����63��C�69�+O���X�o��-�̙#��h0��y%&�QJ1����0&T�!�!�Q�|�H�W��A$C��mP^��˸���98r]��ǼJ�������4f���MLQ �lLk>i:4f��1��ar5��2��;	̐L�]s�3s`wW�2�����C>�N��Ɛ_��(Oߣ3M4��p�SF�S҃��r/��n����!���,��~U��0'�&��9Ѭ���VѬ�ed�E3�&D�1zqE�!R �5��uD�˱?i
"\��LoD����L��P�W�������m(���[��OҎ:�f"�\�(��m9�.���P:K���V���i�a:H�J��TN������Ɩ�� �B,0ʀ��N�	e(@�2��;XV[S��,�g+� ���иB�^��t� �{@}c. ��C�+�?�|!|{��P ,�f�~�!�p�'�n�_���sQ�M���}��
	������@iͿp]�z8f@mp��Y� @&���C�zMV�\����8��b��MC�/��T����}X�zQ�Čޕ?��U6)Eu���Aa��*M�����4�K?�G��/�Af�i�H�*M�ڑ�>������0��t}��0!J��/������T���HNW�<�Z������)3����-�I�s,P!���W^!ѕ��W���y���kӝ�+���U��:?�e�ڔ�6�D�.�K��S���z��L��{���UI�����d�L��TIb֩<q�
Q*K�N�*	�,r1�����ȡ�x�SbRs��J�$&�R�x%�H���R�Ja|�e�J*��4й�d���)s%� �мvnkx=)��d")�����S=���=L��r��i�x�a03��8i�܇"�!So�lU�%�k��T��Qe��������$�Ӆ	.��4$��k埕��BXx5��ڮ�b�
���?wF!�jT!t�!���y-�U���T��,'��GtC�P�& �̅�J`׿pVȆ��&�3�v�O?B�n��bP<�k�.�{�IeX׋�dV��l�ք���Zә\��kn�hV�K��Y�42Odd��V�`���̡B1@����WD1*岼��<3R�FU�k�Q�k����p�F<���(h���N�vT�ċBy���Ĝ���Hk�Uo�t�{�f{�x��tWY�&�;gT�֨�ӟ�"�r�E��(k�Ry�f7_#(U�LsNY#)�T��#+�s�QJ��TRR�����ؠ�4�RYK����c0��&�23��yݔ��O�R#+x_FϿ@X���b���T/��R��u�F\����&�yS���8h�@V���p�zw�i;e��.�mL�z���6��Ù��IsvYR�\�98�+�^3e�$tXe���ndQ�U����iV��3��U�C���ʄ{Z}��k�w�o��,-+N0���M�͑�3��6ס��~]W��.ʉ��٢� �I��4���2����Uצ��X��l%X�f�t����ͳI��Ts}qݙ���ǖ%�n��U	Zm�;��'�a�e` s$ܚ��a��l�y���Oc���z���tS#;�J1�]����s7Oi��1���.W�3��V�p����vc5�#x�N��`��v��T����s�,bc��_.��z�������*f����\XL��G���fr����-ձ~�9�:6�����Km��
+u4ׁ���f:XQA�9���d�GB��HŊ���c2œ����:�����A�/��L��#թ��Q	4=�4���D�ڻ����RCZ��(���4�w���@A��v�ҟ��M�j-�	=����n��j)��Q5�Z
\�Տ�D����Z�]���tǱ2�Hq �I���
�{��Ho�����]��/Yg/�Z�Vw7����6R��Xynk^�n�����Mϼޚm�M�5�9*��Ea��m�����ȵ)̒�w�7X����sS��<�=�l
Ӽ�g��F"C�9t�(����3&�TF!�C�F��^�{h�Hcғv15��K�^JO��H\��9����5�a� )a���}�����ei��
���M�[��'���2����M7^�2�k��j�6���E�u �  �7R��5�^�2�Z/�iݜmdίL�(i����?��%S��>R�o�]�[imԋ�-Ui�>=�K��ؽs � %6��F�}kז���[��D#Gl���U҂j�o�jm]���Em����^;��^+SNݽ��=lSgX���%"��A:j�pT��y4�ֻ�u�]yQ��A6jE�7�!5G�ҍ��ڎ��9��1�Ք_�19�qzջ�tN�w��A/����rax�C�BE�*��'�,H��o[�:� 
B/�A�Z� u�� ����^� �=���]a���h��7�G?���ٺ���:�gF��U�)�M&�Ｓ�Đ�8�E�&��~��j�YƷ�MR�ɉ���6��ݩ�.�q��E�)������\A\][2�U1����M�nNfgw�~J��pba��.S�j}�Bk��Erנ!u����c���@P|��T���F��:CL0��
�!��ؠ4i}s���ɕ^G'��ߴ�dCOjo�єҀM������U������:)�2=e�����.��V�V�W�zP���!yS�T��mQ�2 )�����^1	�
&^WA �5�T�w|@VF��i��ׂ8*s�K]�2r@Wt͸��
�|W*�9��&�4(�k��_���g���PM倰��Ex|�"q����nA\��v��L6�a��JPYȚ�~�޲~F��'^��g�{�*c6L2�x�yr(Mtvb�*Ӝ�K\����FJ)�^t�ᢣf�)2{��'A�c�^�Wt�"(Ox�����q��<f@_������:��N-� r"˨ڼ�4��k��$2A����U
��'G��t�GIgB�К�6a���>V*�����3
���#5m�E��&��*{� ��9��!�V��D��v�X
������N����f�yФ5Q��hY��������N���
BJ���Ab#xQP�3�h.9�	B��~
Jb�4��/.x��8i=�@Gc(m��AC�T����ZHU(if�c�*�=A�������L��~�L�z�c� �i��<�B������Z��< y!�`�΀����W��� >�ct��^�W�DYT�x,X���:�{�s2PL:?�L-�/�#	�HD	v@\Ж�"4��)]ֺTq��vj��X�go��)~�Bx�5�HK�0@gq@��t�<�xTE��s7_h]i��8�U�/�" ,�t]�
��ᵻ�<Ai���<0ȉ����3 )�HNy�&�w{6�A{�d����ޱ�6nMQ��:Ҷ5Á�c�ۑ�;�������IE�g�O��
2;��Դs���U�I8����1����d�թ@DP�Z!kE>�(X^�̈�4�=x�$��iQi�����"�b�U9�A�A��i���:�0՜�D�q��NA�ap�.�&B����Gh	Zu1(�%@g�7�!R�����C?n�R��71����ŻM/��]�;/:�hrJ�:7^���dl���f�������~Z ����G���+�t�*�.j�ϑ~�N��:���1LD9/3��g+"�Ѩ���F�ҝ�)�RH��0�g���e�}�jܞ�L�M��`Fc��-��`�ǫ6�K?�\�6�##Иԇj��=���ɩ��x2�p��^u��"�H9׵������Dҙڠ��	���;p�#��������s�hTG��<ID�zIU`"� �L١G��O:���k��~"m�HC���#���d��Ј:`��e�<4����mD d�9��,�\��a*lZCD݆P`y��J�x��G����[?��Y��BY��RZ��_U@MD)�$��֍ ���p�h���L�7/��}29��+����n0����m���� 1J&�� �-�"�L��҉V�z��(���^���(�������V���K%��1�{��ËQ��泲����j����ql�ԯi�(F������E.ju?J������:���u��X���&�����hEخn2��I;wY,b�>Q�	'��EA�2���ikz7׈z��w���
�_J��J@�Bh� XguB)B�:�CVׄZd��]�P���9��0z!��r�<��@*B�@*����Xr*L���I�I*B{�6QM�y����y�T����ޥ���^��9Ղ�]Ϫ$#�z��[c�%$�h	�(�x���c	� �P�c4�9{�^��E�"BL8f �"Tkm����F���r����P�K�9��'���+I��J���9�����ld��~�v�2i6������$�#��RVw�j��~��P��r^&�0O�)~x?��&d$(�Q��� ry?�!�N�3`(Hx�/IHG��G7����!%�#4�׺*P���$		�B�P��٠�>~�87��qX��>3��d���?:���I����G��~�)��o5;�u�3$�cF�Lne��K}�W�RQ^��O�h���F���L�f#�g������ۍ���va���k}���G��Z-}�\^���o8*��GXϝI�����������c��H[�]�"B�f�M�W4O��l�^4�s��?�{W�/�z�g��=�zT�:'==P,y7�l9�;�����\'��^̅�\�L�I���J�I���k�"�'ق�eϊ���6&d$���	%	��}��r�����tZ��#��u.
$�I��hz��b`R�l5�s������ ,yoa��0a.e^�l����(�n������StŖQ��dPMU>�w}>�ע,1ׅ����Hk�;��i����[�%�(߸~�"-Q�LB��a��@��-���݋'��JTMu�1��+� �ǜ�@Vb���$4w�YMC�RY���tޥ{ߴhV����EW����_��y���".Q����J���%�s�w�EV��)'D-�²"m���E�*�M�K���K��k����Q�rX>c,w�	%��M (Q1�ɢ%�q��EH@��m��?��""1���>��""1���
�����Џ��C�0������G��� xI����r��d-��EA@J!�R(.��aעq]�98j��~nn�V�m����GVtr��"!1=�z�(ި����e�"B�X��7�����)���耢��լ��$�g棍V�\�%I?�I
���o4t9�h�5�ED��)7�P� o��ii���.w��oS���>o�4Ο4z��R��鯾����p��� ]���������f���A�      �   T   x�3�t��/���K�,�T�447KN�2�tJ��R����9���K�S�@��I���I\&���ɩ���E�`��d#SC�=... ���      �   �  x�E��r�0���S�Yl�c�N��I'�!����Z����@�}�J��{��I���HZ$y�Ӛe�%Y��|��~�%ңY����B�W���Z*���9=��D�@%�����Xd\C!��a�VBr����s��0�嫶�Y�8�w�sn���fl�n�z�Y�ϪD&����1=�txM|�f���,,Cޘn��ln"⣱V�,AH���_��n0�髇�Eł��$��#�eF�n�yXQ�T��3���i�{�UdwD��5>,��NT�N�E=�\�	*čyc�QK���2L��RrtXf��[��9"0�c@���#�"%�����?ퟜ9ٯ�L�h(��p1v^�D�0�<�P1��Y���\YF��뒔��m��R.ԩ\�C縲X���D��\-1�C���'�!�kJ�?���*���Pq�j���KU���o]��������H7׺n$�J]��5~@i㶏������^��<Xk��:j�����w�      �   �  x�Ŕێ�Fǯ�O�Ze{�3`)j�cl0����1�s0���wȃu�i�F��*B��7������j-*�!��!됬��9�1�]u�s��4m�ýA �m �!~�RH=A��2�9����A�No���9��My�mw�����E��<�06�N)P[�%���K� y�km�|��/��G�,�u��O����S9<B�����_r�k�?XU�������FK�Ļ���r��8]����xUf�QQ��ߞ�,z�=�E��n7/Ι�Np>qS�߅t�0���}_%���a��i����e�=y7&�dy��y�����W�p�.�p{���?+0��3��hCb8���^��=���8Ќ�ݜ�]?�I�����T�74R7�9ɮ�#����U�/j��4��Ep� ���A�eF>�?v¼�[�09U���O�<n�Lp��L,�{�t?��<�|ok��fk+�F�<��=Ԛ�}&}) �3R(���R\�-��MR�h=_�ǉ��Hkj+���/������,v�a�dsov;�Dz�:�y�����pcڻ:;����׼Xg�y�+Zhx��lw^Vщ���$<��ʦH�VR]%q�4'�C�5��H�X��ӈN�4��ų� *Ҋ��2�^�ɔu` ���vYɶ�LrdM�C?'���	��5���" ���Y���2�*�:�.c�
�ǡ����{��?�E��;��}�I߻�%������)$4������|u����3�[|=/!ſ!����rm�Hz�B��I@���-�0I�rG˶��6���F����0�J������/�~�$������[(R��N�k!����ZBx�e�� �l+*#}�֕Y܉2'�JEJz}��b�1�m@ܬ�����VG�>䄙%2V�����|e��qؤ�@Cj|��Е�+�-���T������70g��(�A��wyߜ Z�L�{�{�v���h�R��Z���H�����W/����\����Ӧ�je-Vt`N��r��Z-�W���%.o�����f�e����Ɍ��fi�\��Aq�����\��ת\J�E, �<�����^������F�3�m;g9�ˆ{U��im�L�A^f(�ٷ�9�?"�M=�a�o
 |�P�S������nv�     